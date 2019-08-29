Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E980A12CB
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 09:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfH2HqJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 03:46:09 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33978 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfH2HqJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 03:46:09 -0400
Received: by mail-pg1-f201.google.com with SMTP id x19so1523574pgx.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2019 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=W1PmjVL/6s5ZXXFzVRoWXIYsoDfmFEis3kh7AY5/b/U=;
        b=BlBlZcZoKDjgUAr7XG6MtHOGce0R3ksWhAYokbXmmIBoBJml3QfGoVZnzlSpGJZ7fo
         ctBud1He4pmoya0E8XD2Q32uvOOZ0BdedmzPEab50lAtOEa+5NeR03NsNnFtyn3WRkTE
         g3GM3mZhgXqy4srOHzbGLNj8cSyz+++EWnPSUacRg70jS7mzrzEM+zqmkOEE8qMbOon7
         5JWBj0P+lhdTL7oESqnUj3SisI1jTDbiiABGWvDD8AqArQBJXi820TWLlnBCxW6YvuSX
         LgaKO0ZVZPjezsn1SEIfqZvIaXIZNMVbBPdSuSd0rbrNZSILWVwusSRflGEGf5Z83xwa
         Xv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=W1PmjVL/6s5ZXXFzVRoWXIYsoDfmFEis3kh7AY5/b/U=;
        b=L5hRW8OgEu+Dc+yXrXbR0vjUiJYV/qtDjF7WFLQV518HAqS6VlGAdhdP6vYg/HpeWq
         m58pd+1jMd7MAL+Jhe7PYvPf6OD4Bb0Kd6ErNaMy9RKaL0fFOJtSmy3jtu3Ee8BeP2Ke
         G6YLnGEP2w3q5Sj8kL7eA+IcjgZkUoxmfzc4IYvuOdAWtrngh0zCfktM4nmmokrsuZOm
         +mEmgLYKJSk2PEM0n71wfC5BAEfcZ2jJOlUSGCp2PrCLK6pdP+ljlSzfeKvMRRdjtk0E
         5BD/mXEICNmcrwcCX7JAk425dXLmI+0Ty6kAvyHGCP1cn+ZlkE6elVTS3gQzN4VFC4LQ
         UmEw==
X-Gm-Message-State: APjAAAW38P/AvRRlbLnZwDfI95GczX61uNZJ0XY7pNF1xLPnM1mFHUdK
        G21/7l9mQ/1EF91DNa3ym874FgS+OEa0JOY=
X-Google-Smtp-Source: APXvYqx8b6RNwtvC8vhWCgQOo7SditWRgK6j21AF90oa0Vxuu2xB7Qykx4b8MpO0DR/c1K1mehO1tLGPMlWRAhs=
X-Received: by 2002:a63:6901:: with SMTP id e1mr6839120pgc.390.1567064768278;
 Thu, 29 Aug 2019 00:46:08 -0700 (PDT)
Date:   Thu, 29 Aug 2019 00:45:56 -0700
Message-Id: <20190829074603.70424-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v10 0/7] Solve postboot supplier cleanup and optimize probe ordering
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add device-links to track functional dependencies between devices
after they are created (but before they are probed) by looking at
their common DT bindings like clocks, interconnects, etc.

Having functional dependencies automatically added before the devices
are probed, provides the following benefits:

- Optimizes device probe order and avoids the useless work of
  attempting probes of devices that will not probe successfully
  (because their suppliers aren't present or haven't probed yet).

  For example, in a commonly available mobile SoC, registering just
  one consumer device's driver at an initcall level earlier than the
  supplier device's driver causes 11 failed probe attempts before the
  consumer device probes successfully. This was with a kernel with all
  the drivers statically compiled in. This problem gets a lot worse if
  all the drivers are loaded as modules without direct symbol
  dependencies.

- Supplier devices like clock providers, interconnect providers, etc
  need to keep the resources they provide active and at a particular
  state(s) during boot up even if their current set of consumers don't
  request the resource to be active. This is because the rest of the
  consumers might not have probed yet and turning off the resource
  before all the consumers have probed could lead to a hang or
  undesired user experience.

  Some frameworks (Eg: regulator) handle this today by turning off
  "unused" resources at late_initcall_sync and hoping all the devices
  have probed by then. This is not a valid assumption for systems with
  loadable modules. Other frameworks (Eg: clock) just don't handle
  this due to the lack of a clear signal for when they can turn off
  resources. This leads to downstream hacks to handle cases like this
  that can easily be solved in the upstream kernel.

  By linking devices before they are probed, we give suppliers a clear
  count of the number of dependent consumers. Once all of the
  consumers are active, the suppliers can turn off the unused
  resources without making assumptions about the number of consumers.

By default we just add device-links to track "driver presence" (probe
succeeded) of the supplier device. If any other functionality provided
by device-links are needed, it is left to the consumer/supplier
devices to change the link when they probe.

v1 -> v2:
- Drop patch to speed up of_find_device_by_node()
- Drop depends-on property and use existing bindings

v2 -> v3:
- Refactor the code to have driver core initiate the linking of devs
- Have driver core link consumers to supplier before it's probed
- Add support for drivers to edit the device links before probing

v3 -> v4:
- Tested edit_links() on system with cyclic dependency. Works.
- Added some checks to make sure device link isn't attempted from
  parent device node to child device node.
- Added way to pause/resume sync_state callbacks across
  of_platform_populate().
- Recursively parse DT node to create device links from parent to
  suppliers of parent and all child nodes.

v4 -> v5:
- Fixed copy-pasta bugs with linked list handling
- Walk up the phandle reference till I find an actual device (needed
  for regulators to work)
- Added support for linking devices from regulator DT bindings
- Tested the whole series again to make sure cyclic dependencies are
  broken with edit_links() and regulator links are created properly.

v5 -> v6:
- Split, squashed and reordered some of the patches.
- Refactored the device linking code to follow the same code pattern for
  any property.

v6 -> v7:
- No functional changes.
- Renamed i to index
- Added comment to clarify not having to check property name for every
  index
- Added "matched" variable to clarify code. No functional change.
- Added comments to include/linux/device.h for add_links()

v7 -> v8:
- Rebased on top of linux-next to handle device link changes in [1]

v8 -> v9:
- Fixed kbuild test bot reported errors (docs and const)

v9->v10:
- Changes made based on reviews on LKML [2] and discussions at ELC [3]
- Dropped the edit_links() patch
- Dropped the patch that skips linking for default bus nodes
- 1/7: Changed from bus.add_links() to fwnode.ops.add_links() 
- 1/7: Update device link doc
- 1/7: Lots of comments/fn doc updates
- 1/7: Renamed device_link_check_waiting_consumers() to
  device_link_add_missing_supplier_links()
- 2/7: Moved DT parsing/linking code from of/platform.c to of/property.c
- 2/7: Lots of comments/fn doc updates
- 2/7: Returned errors for all error cases in of_link_to_phandle()
- 2/7: Some minor code refactor to remove "bool done"
- 2/7: Added debug messages when links not created due permanent errors
- 3/7: Minor comments update
- Added 2 new patches 6/7 and 7/7 to handle cyclic dependencies using
  depends-on

[1] - https://lore.kernel.org/lkml/2305283.AStDPdUUnE@kreacher/
[2] - https://lore.kernel.org/lkml/20190724001100.133423-2-saravanak@google.com/
[3] - https://lore.kernel.org/lkml/CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com/

-Saravana

Saravana Kannan (7):
  driver core: Add support for linking devices during device addition
  of: property: Add functional dependency link from DT bindings
  driver core: Add sync_state driver/bus callback
  of/platform: Pause/resume sync state during init and
    of_platform_populate()
  of: property: Create device links for all child-supplier depencencies
  dt-bindings: Add depends-on property to break cyclic inferred
    dependencies
  of: property: Add "depends-on" parsing support to
    of_fwnode_add_links()

 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |   6 +
 .../devicetree/bindings/depends-on.txt        |  46 ++++
 Documentation/driver-api/device_link.rst      |   3 +-
 drivers/base/core.c                           | 154 +++++++++++
 drivers/of/platform.c                         |  12 +
 drivers/of/property.c                         | 258 ++++++++++++++++++
 include/linux/device.h                        |  26 ++
 include/linux/fwnode.h                        |  17 ++
 9 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/depends-on.txt

-- 
2.23.0.187.g17f5b7556c-goog

