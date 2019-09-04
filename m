Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78EA948E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 23:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfIDVLc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 17:11:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:46395 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbfIDVLc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 17:11:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id k9so82045pls.13
        for <linux-acpi@vger.kernel.org>; Wed, 04 Sep 2019 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u6P0vTia2RxCdsskGV2Xe3w3VBUYzUpmbJKpNal4IZw=;
        b=hsXuOq4U7Hvf3+Aw42QvXQCMdUYeVEyK0fec5z9mwWg/bs6Scs6nwXwZNMourwGQVm
         7MJGzsG1OLHJIXA9pmHevdTrdOK9qq6Hak0h/NnCo3E5lvSi6Ki8Zb/1Wi8K1Sh7qUDF
         regS6AmwPMqqTDxHYDUX1U34olvb0UwCH88he5VII6X6Ckvietiyas6yicLPJMT06/Nj
         AVE0f7vV+nd4dQZCuJeKYOB/+wP3ZtdVZWHEqQY80OpZOQigFszsAG1vFOd0ryc02YNF
         rZvIl2NjmTqIZzJPGHGnaoYZls49JMMfpo37V7SSp8mZemetqwr3DSjnN6PYlOJIlQ6Q
         PHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u6P0vTia2RxCdsskGV2Xe3w3VBUYzUpmbJKpNal4IZw=;
        b=Y0DVV/Vs0C3llbmjQrvjcGhLTHjAA8tUe7ekxmMhiWqp73jWa69uaYqXydYPTyd+EE
         RV20n1Q1w8vJBRwHAJ5bZ6HANi1OJls7i8G7BSy6gIIf+NtM/TWDPk//DjAAmkt0Azn6
         oK6WfCxX9FapwIqgxGugD+ArKxBwk/TcIuoXVcIet4bTJsBExx5so3MU1AcPZTz8vHlc
         0t0GSqIZ70gcdO2i7yUMymZfcx7pYnhn2YzsQqcx4eMXynxWwZQrYvt63C012NwgQZ9S
         vGoa1TEjdPeJjYVKzms94ir1N1P3/ZosmvJxfxp/ozXjG9qZwSUAVOMRCQ2bx8IQQFbD
         cRaA==
X-Gm-Message-State: APjAAAVTIUlf86RP737/2RUn6SJD4BEblwBoWYqtH1NJVY2JyeE8grKU
        VzgS0xwffc076i/eC5o3gn55xys6eKzl5lE=
X-Google-Smtp-Source: APXvYqzFJhNEj47Q9YRnGctnszvBFE5bLucB5Efpxvkp2c4kvXSYRccx8tAfNHCR2YaO0Z/cUY/FYqT5HsWndZo=
X-Received: by 2002:a63:ec03:: with SMTP id j3mr111690pgh.325.1567631490651;
 Wed, 04 Sep 2019 14:11:30 -0700 (PDT)
Date:   Wed,  4 Sep 2019 14:11:19 -0700
Message-Id: <20190904211126.47518-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v11 0/6] Solve postboot supplier cleanup and optimize probe ordering
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

v10->v11:
- Dropped 6/7 and 7/7 from previous series that tried to handle cycles in DT
  dependencies. We can solve it later when we actually hit a real world issue
  in DT.
- Added a new 1/7 that shifts the numbering for the rest of the patches
- 1/7 adds a way to look up a device from a fwnode so that this series can work
  across bus and firmware types
- 3/7 removed references to platform_device from of/property.c
- 4/7 Minor variable rename
- 4/7 Defer sync_state() be default at driver core level and resume at
  late_initcall_sync(). That way, we don't depend on any specific bus types
  having to pause/resume sync_state() till late_initcall_sync()

[1] - https://lore.kernel.org/lkml/2305283.AStDPdUUnE@kreacher/
[2] - https://lore.kernel.org/lkml/20190724001100.133423-2-saravanak@google.com/
[3] - https://lore.kernel.org/lkml/CAGETcx_pSnC_2D7ufLRyfE3b8uRc814XEf8zu+SpNtT7_Z8NLg@mail.gmail.com/

-Saravana


Saravana Kannan (6):
  driver core: Add fwnode_to_dev() to look up device from fwnode
  driver core: Add support for linking devices during device addition
  of: property: Add functional dependency link from DT bindings
  driver core: Add sync_state driver/bus callback
  of/platform: Pause/resume sync state during init and
    of_platform_populate()
  of: property: Create device links for all child-supplier depencencies

 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/driver-api/device_link.rst      |   3 +-
 drivers/base/core.c                           | 167 ++++++++++++
 drivers/of/platform.c                         |  12 +
 drivers/of/property.c                         | 245 ++++++++++++++++++
 include/linux/device.h                        |  26 ++
 include/linux/fwnode.h                        |  19 ++
 8 files changed, 478 insertions(+), 1 deletion(-)

-- 
2.23.0.187.g17f5b7556c-goog

