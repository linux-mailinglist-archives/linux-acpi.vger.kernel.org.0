Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48D462B2C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2019 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfGHVjg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jul 2019 17:39:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39505 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbfGHVjg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jul 2019 17:39:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so13805801oig.6;
        Mon, 08 Jul 2019 14:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=a3+NVcvGjIFNIsu4MkqNVhhsufaUW+do2rR/ZlfhCf0=;
        b=N+kPkeGHfmLKrVRfMK/7bLr/rZOAgIAsbDF4yDakVtHKif5ouoeDvw0nUfhyQfF+ly
         eHJzEmxHJtXgvP3zEq9SezyP/LbhpEj3IG8YiHdS0z8A3oeCZcdB/VcTXOPLoMud+FyI
         lxsBMmc5zIYphA5/40ArRt3kx/QTMbZXlu0P1X5be5FxAb8i/5SuiBYdNN11R9JzayVl
         tSEizMaNNWQRCQZzU5kXjI0DdA5v2chJ6OqAiyWDooqHXDXpWbMSHeVNsCmmmCVvbJQ9
         kiok6UfWcjbQtMaGnpCH4L2nKA8FwN+lX+odXJBLr+PBpMPS2I3ifTucLcLLRoohzMsV
         l40g==
X-Gm-Message-State: APjAAAW+tqqNfkK9fpTgsKnLhUf+gxUZl9ImoyC3UjCipjnRxOK6JmUQ
        RKZlJabNhIjqe8xG3mHrKZTTnnnYYMLHc2YmpLo=
X-Google-Smtp-Source: APXvYqyieHJpGxx2Rx0jBZKetIMt84cplqpTBXybYOOeaI3d8n2wUaLHKlR6hT6AZIqbH73eQ3Jm2mwd/Muc8YLW16I=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr10844220oib.57.1562621975827;
 Mon, 08 Jul 2019 14:39:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 23:39:24 +0200
Message-ID: <CAJZ5v0g8O+XLjSarCiZcj0LnSZYnCqGE3D6tfFD30wOZjprb2g@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.3-rc1

with top-most commit 33ee09cd59ce154b64f9df942dfa5456db90d5f9

 device property: Add helpers to count items in an array

on top of commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a

 Linux 5.2-rc3

to receive device properties framework updates for 5.3-rc1.

These add helpers for counting items in a property array and
extend the "software nodes" support to be more convenient for
representing device properties supplied by drivers and make
the intel_cht_int33fe driver use that.

Specifics:

 - Add helpers to count items in a property array (Andy Shevchenko).

 - Extend "software nodes" support to be more convenient for
   representing device properties supplied by drivers (Heikki
   Krogerus).

 - Add device_find_child_by_name() helper to the driver core (Heikki
   Krogerus).

 - Extend device connection code to also look for references provided
   via fwnode pointers (Heikki Krogerus).

 - Start to register proper struct device objects for USB Type-C
   muxes and orientation switches (Heikki Krogerus).

 - Update the intel_cht_int33fe driver to describe devices in a more
   general way with the help of "software nodes" (Heikki Krogerus).

Thanks!


---------------

Andy Shevchenko (1):
      device property: Add helpers to count items in an array

Heikki Krogerus (16):
      software node: Allow node creation without properties
      software node: Simplify software_node_release() function
      software node: Add support for static node descriptors
      software node: Use kobject name when finding child nodes by name
      software node: Add software_node_get_reference_args()
      driver core: Add helper device_find_child_by_name()
      ACPI / property: Don't limit named child node matching to data nodes
      device property: Introduce fwnode_find_reference()
      device connection: Find connections also by checking the references
      usb: typec: Registering real device entries for the muxes
      platform/x86: intel_cht_int33fe: Register max17047 in its own function
      platform/x86: intel_cht_int33fe: Remove unused fusb302 device property
      platform/x86: intel_cht_int33fe: Provide software nodes for the devices
      platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
      platform/x86: intel_cht_int33fe: Supply fwnodes for the external
dependencies
      platform/x86: intel_cht_int33fe: Replacing the old connections
with references

---------------

 drivers/acpi/property.c                  |  26 ++-
 drivers/base/core.c                      |  28 +++
 drivers/base/devcon.c                    |  26 +++
 drivers/base/property.c                  |  24 +++
 drivers/base/swnode.c                    | 324 ++++++++++++++++++++++++-------
 drivers/platform/x86/intel_cht_int33fe.c | 291 ++++++++++++++++++++++-----
 drivers/usb/roles/class.c                |   2 +-
 drivers/usb/typec/bus.h                  |  15 ++
 drivers/usb/typec/class.c                |  17 +-
 drivers/usb/typec/mux.c                  | 238 ++++++++++++++++-------
 drivers/usb/typec/mux/pi3usb30532.c      |  46 +++--
 include/linux/device.h                   |   2 +
 include/linux/property.h                 |  95 +++++++++
 include/linux/usb/typec_mux.h            |  62 +++---
 14 files changed, 947 insertions(+), 249 deletions(-)
