import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/services/events_service.dart';

class CreateEventNotifier extends StateNotifier<Event> {
  final EventsService _eventsService;

  CreateEventNotifier({
    EventsService? eventsService,
  })  : _eventsService = eventsService ?? GetIt.I<EventsService>(),
        super(Event());

  void initializeWithEvent(Event event) {
    state = event;
  }

  void updateEventDetails({
    String? name,
    String? description,
    bool? isPublic,
    bool? requiresApproval,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    state = state.copyWith(
      name: name,
      description: description,
      isPublic: isPublic,
      requiresApproval: requiresApproval,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
    );
  }

  void addStage(EventStage stage) {
    final List<EventStage> stages = List<EventStage>.from(state.stages);
    stages.add(stage);
    
    // Since the Event.copyWith() method doesn't accept lists directly,
    // we need to update the state and then modify its properties
    final newState = state.copyWith();
    newState.stages.clear();
    newState.stages.addAll(stages);
    
    state = newState;
  }

  void updateStage(int index, EventStage stage) {
    final List<EventStage> stages = List<EventStage>.from(state.stages);
    if (index >= 0 && index < stages.length) {
      stages[index] = stage;
      
      final newState = state.copyWith();
      newState.stages.clear();
      newState.stages.addAll(stages);
      
      state = newState;
    }
  }

  void removeStage(int index) {
    final List<EventStage> stages = List<EventStage>.from(state.stages);
    if (index >= 0 && index < stages.length) {
      stages.removeAt(index);
      
      final newState = state.copyWith();
      newState.stages.clear();
      newState.stages.addAll(stages);
      
      state = newState;
    }
  }

  void addRequiredItem(EventItem item) {
    final List<EventItem> items = List<EventItem>.from(state.requiredItems);
    items.add(item);
    
    final newState = state.copyWith();
    newState.requiredItems.clear();
    newState.requiredItems.addAll(items);
    
    state = newState;
  }

  void updateRequiredItem(int index, EventItem item) {
    final List<EventItem> items = List<EventItem>.from(state.requiredItems);
    if (index >= 0 && index < items.length) {
      items[index] = item;
      
      final newState = state.copyWith();
      newState.requiredItems.clear();
      newState.requiredItems.addAll(items);
      
      state = newState;
    }
  }

  void removeRequiredItem(int index) {
    final List<EventItem> items = List<EventItem>.from(state.requiredItems);
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      
      final newState = state.copyWith();
      newState.requiredItems.clear();
      newState.requiredItems.addAll(items);
      
      state = newState;
    }
  }

  void addActivity(EventActivity activity) {
    final List<EventActivity> activities = List<EventActivity>.from(state.eventActivities);
    activities.add(activity);
    
    final newState = state.copyWith();
    newState.eventActivities.clear();
    newState.eventActivities.addAll(activities);
    
    state = newState;
  }

  void removeActivity(int index) {
    final List<EventActivity> activities = List<EventActivity>.from(state.eventActivities);
    if (index >= 0 && index < activities.length) {
      activities.removeAt(index);
      
      final newState = state.copyWith();
      newState.eventActivities.clear();
      newState.eventActivities.addAll(activities);
      
      state = newState;
    }
  }

  Future<bool> saveEvent() async {
    try {
      final eventId = state.id;
      final isUpdate = eventId != null;
      bool success;
      
      if (isUpdate) {
        // Update existing event - we'll need to implement this in the EventsService
        success = await _eventsService.updateEvent(state);
      } else {
        // Create new event - we'll need to implement this in the EventsService
        success = await _eventsService.createEvent(state);
      }
      
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteEvent() async {
    if (state.id == null) {
      return false;
    }
    try {
      // Delete event - we'll need to implement this in the EventsService
      final success = await _eventsService.deleteEvent(state.id!);
      return success;
    } catch (e) {
      return false;
    }
  }
}

final createEventProvider = StateNotifierProvider<CreateEventNotifier, Event>(
  (ref) => CreateEventNotifier(),
);

final activityTypesProvider = FutureProvider<List<SocialActivityType>>((ref) {
  // Return all available social activity types
  return SocialActivityType.values.toList();
});
