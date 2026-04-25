class HomeScreen extends StatelessWidget {
                      value: state.filterId,
                      hint: const Text('Filter by student'),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem(value: null, child: Text('All')),
                        ...state.students.map((s) => DropdownMenuItem(
                              value: s.id,
                              child: Text(s.name),
                            ))
                      ],
                      onChanged: (val) {
                        bloc.add(Filter(val));
                      },
                    ),

                    const SizedBox(height: 16),

                    // LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.students.length,
                        itemBuilder: (_, i) {
                          final s = state.students[i];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: ListTile(
                              title: Text(s.name),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  bloc.add(AddAct(s.id));
                                },
                                child: const Text('Active'),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StatsScreen(filteredActivities),
                          ),
                        );
                      },
                      child: const Text('View Statistics'),
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
