import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:motomeetfront/models/event.dart';
import 'package:motomeetfront/models/enum.dart';
import 'package:motomeetfront/models/route.dart';
import 'package:motomeetfront/services/events_service.dart';

class CreateEventState {
  final Event event;
  final int currentStep;

  CreateEventState({
    required this.event,
    this.currentStep = 0,
  });

  CreateEventState copyWith({
    Event? event,
    int? currentStep,
  }) {
    return CreateEventState(
      event: event ?? this.event,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

class CreateEventViewModel extends StateNotifier<CreateEventState> {
  CreateEventViewModel() : super(CreateEventState(event: Event()));

  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void updateEvent(Event event) {
    state = state.copyWith(event: event);
  }

  void setEventTitle(String name) {
    state = state.copyWith(event: state.event.copyWith(name: name));
  }

  void setEventType(EventType type) {
    state = state.copyWith(event: state.event.copyWith(eventType: type));
  }

  void setStartDate(DateTime date) {
    final current = state.event.startDateTime ?? DateTime.now();
    final newDate = DateTime(date.year, date.month, date.day, current.hour, current.minute);
    state = state.copyWith(event: state.event.copyWith(startDateTime: newDate));
  }

  void setStartTime(DateTime time) {
    final current = state.event.startDateTime ?? DateTime.now();
    final newTime = DateTime(current.year, current.month, current.day, time.hour, time.minute);
    state = state.copyWith(event: state.event.copyWith(startDateTime: newTime));
  }

  void setDuration(Duration duration) {
    state = state.copyWith(event: state.event.copyWith(durationInMinutes: duration.inMinutes));
  }
  
  void setLocation(String location) {
    state = state.copyWith(event: state.event.copyWith(locationName: location));
  }

  void setBannerImage(String imageUrl) {
    state = state.copyWith(event: state.event.copyWith(bannerImageUrl: imageUrl));
  }
  
  void setDescription(String description) {
    state = state.copyWith(event: state.event.copyWith(description: description));
  }

  void setVisibility(EventVisibility visibility) {
    state = state.copyWith(event: state.event.copyWith(visibility: visibility));
  }

  void setMaxParticipants(int max) {
    state = state.copyWith(event: state.event.copyWith(maxParticipants: max));
  }

  void setExperienceLevel(ExperienceLevel level) {
    state = state.copyWith(event: state.event.copyWith(experienceLevel: level));
  }

  void setAllowWaitlist(bool allow) {
    state = state.copyWith(event: state.event.copyWith(allowWaitlist: allow));
  }

  void setAutoApprove(bool approve) {
    state = state.copyWith(event: state.event.copyWith(requiresApproval: !approve));
  }

  void setRoute(Route route) {
    state = state.copyWith(event: state.event.copyWith(route: IsarLink()..value = route));
  }

  void setAdditionalRouteNotes(String notes) {
    // This needs a field in the event model, e.g., `routeNotes`
    // For now, let's assume we add it.
    // state = state.copyWith(event: state.event.copyWith(routeNotes: notes));
  }

  void setWeatherAlerts(bool enabled) {
    // This needs a field in the event model, e.g., `weatherAlertsEnabled`
    // state = state.copyWith(event: state.event.copyWith(weatherAlertsEnabled: enabled));
  }

  void addEventItem(EventItem item) {
    final items = List<EventItem>.from(state.event.requiredItems);
    items.add(item);
    state = state.copyWith(event: state.event.copyWith(requiredItems: IsarLinks()..addAll(items)));
  }

  void removeEventItem(EventItem item) {
    final items = List<EventItem>.from(state.event.requiredItems);
    items.remove(item);
    state = state.copyWith(event: state.event.copyWith(requiredItems: IsarLinks()..addAll(items)));
  }

  void updateEventItem(int index, EventItem item) {
    final items = List<EventItem>.from(state.event.requiredItems);
    items[index] = item;
    state = state.copyWith(event: state.event.copyWith(requiredItems: IsarLinks()..addAll(items)));
  }

  void setEmergencyContact(String contact) {
    state = state.copyWith(event: state.event.copyWith(emergencyContact: contact));
  }

  void setSafetyNotes(String notes) {
    state = state.copyWith(event: state.event.copyWith(safetyNotes: notes));
  }

  Future<bool> saveEvent() async {
    final eventsService = GetIt.I<EventsService>();
    if (state.event.id != null) {
      return await eventsService.updateEvent(state.event);
    } else {
      return await eventsService.createEvent(state.event);
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < 4) {
      state = state.copyWith(currentStep: step);
    }
  }

  // Add more methods here to update other parts of the event
}

final createEventViewModelProvider = StateNotifierProvider<CreateEventViewModel, CreateEventState>(
  (ref) => CreateEventViewModel(),
); 