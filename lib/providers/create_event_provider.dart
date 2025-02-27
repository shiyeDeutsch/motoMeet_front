import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/services/events_service.dart';
import 'package:motomeetfront/services/service_locator.dart';
import 'package:motomeetfront/services/activity_service.dart';

class CreateEventState {
  final Event event;
  final bool isLoading;
  final String? error;
  
  List<EventStage> get stages => event.eventStages.toList();
  List<RequiredItem> get requiredItems => event.requiredItems.toList();
  List<EventActivity> get activities => event.eventActivities.toList();

  CreateEventState({
    required this.event,
    this.isLoading = false,
    this.error,
  });

  CreateEventState copyWith({
    Event? event,
    bool? isLoading,
    String? error,
  }) {
    return CreateEventState(
      event: event ?? this.event,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CreateEventNotifier extends StateNotifier<CreateEventState> {
  final EventsService _eventsService;

  CreateEventNotifier({
    EventsService? eventsService,
  })  : _eventsService = eventsService ?? getIt<EventsService>(),
        super(CreateEventState(event: Event()));

  void initializeWithEvent(Event event) {
    state = state.copyWith(event: event);
  }

  void updateEventDetails({
    String? name,
    String? description,
    bool? isPublic,
    bool? requiresApproval,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    final updatedEvent = state.event.copyWith(
      name: name,
      description: description,
      isPublic: isPublic,
      requiresApproval: requiresApproval,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
    
    state = state.copyWith(event: updatedEvent);
  }

  void addStage(EventStage stage) {
    final stages = List<EventStage>.from(state.event.eventStages);
    stages.add(stage);
    
    final updatedEvent = state.event.copyWith(eventStages: stages);
    state = state.copyWith(event: updatedEvent);
  }

  void updateStage(int index, EventStage stage) {
    final stages = List<EventStage>.from(state.event.eventStages);
    if (index >= 0 && index < stages.length) {
      stages[index] = stage;
      
      final updatedEvent = state.event.copyWith(eventStages: stages);
      state = state.copyWith(event: updatedEvent);
    }
  }

  void removeStage(int index) {
    final stages = List<EventStage>.from(state.event.eventStages);
    if (index >= 0 && index < stages.length) {
      stages.removeAt(index);
      
      final updatedEvent = state.event.copyWith(eventStages: stages);
      state = state.copyWith(event: updatedEvent);
    }
  }

  void addRequiredItem(RequiredItem item) {
    final items = List<RequiredItem>.from(state.event.requiredItems);
    items.add(item);
    
    final updatedEvent = state.event.copyWith(requiredItems: items);
    state = state.copyWith(event: updatedEvent);
  }

  void updateRequiredItem(int index, RequiredItem item) {
    final items = List<RequiredItem>.from(state.event.requiredItems);
    if (index >= 0 && index < items.length) {
      items[index] = item;
      
      final updatedEvent = state.event.copyWith(requiredItems: items);
      state = state.copyWith(event: updatedEvent);
    }
  }

  void removeRequiredItem(int index) {
    final items = List<RequiredItem>.from(state.event.requiredItems);
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      
      final updatedEvent = state.event.copyWith(requiredItems: items);
      state = state.copyWith(event: updatedEvent);
    }
  }

  void addActivity(EventActivity activity) {
    final activities = List<EventActivity>.from(state.event.eventActivities);
    activities.add(activity);
    
    final updatedEvent = state.event.copyWith(eventActivities: activities);
    state = state.copyWith(event: updatedEvent);
  }

  void removeActivity(int index) {
    final activities = List<EventActivity>.from(state.event.eventActivities);
    if (index >= 0 && index < activities.length) {
      activities.removeAt(index);
      
      final updatedEvent = state.event.copyWith(eventActivities: activities);
      state = state.copyWith(event: updatedEvent);
    }
  }

  Future<bool> saveEvent() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final eventWithId = state.event.id;
      final isUpdate = eventWithId != null;
      
      bool success;
      if (isUpdate) {
        // Update existing event
        success = await _eventsService.updateEvent(state.event);
      } else {
        // Create new event
        success = await _eventsService.createEvent(state.event);
      }
      
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> deleteEvent() async {
    if (state.event.id == null) {
      return false;
    }
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final success = await _eventsService.deleteEvent(state.event.id!);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }
}

final createEventProvider = StateNotifierProvider<CreateEventNotifier, CreateEventState>(
  (ref) => CreateEventNotifier(),
);

final activityTypesProvider = FutureProvider<List<ActivityType>>((ref) {
  final activityService = getIt<ActivityService>();
  return activityService.getActivityTypes();
});
