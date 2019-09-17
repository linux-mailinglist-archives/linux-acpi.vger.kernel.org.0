Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71520B4BEF
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2019 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfIQK12 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Sep 2019 06:27:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44314 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfIQK12 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Sep 2019 06:27:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id w6so2335168oie.11;
        Tue, 17 Sep 2019 03:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jw020uvO5W1dQB83HITZVbJ4+r2ZGjWj7Xyy0Bpkz/A=;
        b=pWZdQumj+lQlUIBL5TQRsUiyyQpOByhRs4rxcfAijA18wPGiXvWDe2JKAg1FRpRWs3
         JNM13bGpRc/PVk5SvU1/p2C8rm9OMSeOMOxh474S//52FfFB0Qa5vzKj6RguCqSWipFm
         /2WX6ghVOkZVwzZ23Knm8pIi+81NpYpjDwciV4MB0ZyxZ902ZOQhlaHSG1F6OmehmR4y
         c57cJxI4TdjcHoiNuUbD+/NcvMyobe+/nNBiM+aOdl/2fBMmTVYYHhUkXVgjK4Ul8Bbr
         zTSCrA31ZaH36dvN9rK3ospDwZzSfGxTZWoycIHO6USwP5zoHweKpPNAqAI5soV3ki8J
         e10A==
X-Gm-Message-State: APjAAAVeYt6q/Ae3Tt1r4KhwEkkbqwT1CHTD51snsiIKLOo8+pmdjW62
        ty0E/WQTGB90gMQujMI6ag+wUq5TtKavmPzEwoX9ZEtx
X-Google-Smtp-Source: APXvYqwazB3v6V1RsjC4YgX0kgioA/H9C3tRozSeoJq3Agt6TGjJtqCyKk1J+MAOyvJmC4bNzH/00mI+LIRfkSZw7Nw=
X-Received: by 2002:aca:ab84:: with SMTP id u126mr2824699oie.115.1568716047201;
 Tue, 17 Sep 2019 03:27:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Sep 2019 12:27:16 +0200
Message-ID: <CAJZ5v0iJupxXBYRDeV4_V14je-uZYRf7d_CZ7WRUw7++n_575Q@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.4-rc1

with top-most commit 016049a816774edc9c3cd81afa7724d7ab001585

 software node: Initialize the return value in software_node_find_by_name()

on top of commit a55aa89aab90fae7c815b0551b07be37db359d76

 Linux 5.3-rc6

to receive device properties framework updates for 5.4-rc1.

These include software node support improvements (Heikki Krogerus)
and two assorted cleanups (Andy Shevchenko, Geert Uytterhoeven).

There was a conflict between this and the USB tree in linux-next
which was resolved by Stephen by applying the appended diff.

Thanks!


---------------

Andy Shevchenko (1):
      device property: Remove duplicate test for NULL

Geert Uytterhoeven (1):
      ACPI / property: Fix acpi_graph_get_remote_endpoint() name in kerneldoc

Heikki Krogerus (5):
      software node: Add software_node_find_by_name()
      usb: roles: intel_xhci: Supplying software node for the role mux
      platform/x86: intel_cht_int33fe: Use new API to gain access to
the role switch
      software node: Initialize the return value in software_node_to_swnode()
      software node: Initialize the return value in software_node_find_by_name()

---------------

 drivers/acpi/property.c                        |  2 +-
 drivers/base/swnode.c                          | 39 +++++++++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c       | 57 +++++---------------------
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 27 ++++++++----
 include/linux/fwnode.h                         |  9 ++--
 include/linux/property.h                       |  4 ++
 6 files changed, 78 insertions(+), 60 deletions(-)

---------------

diff --cc drivers/usb/roles/intel-xhci-usb-role-switch.c
index 7325a84dd1c8,88d041601c51..000000000000
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@@ -37,12 -44,9 +44,13 @@@
  struct intel_xhci_usb_data {
      struct usb_role_switch *role_sw;
      void __iomem *base;
+     bool enable_sw_switch;
  };

 +static const struct software_node intel_xhci_usb_node = {
 +    "intel-xhci-usb-sw",
 +};
 +
  static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
  {
      struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
@@@ -147,20 -167,12 +167,22 @@@ static int intel_xhci_usb_probe(struct

      platform_set_drvdata(pdev, data);

+     data->enable_sw_switch = !device_property_read_bool(dev,
+                         "sw_switch_disable");
 +    ret = software_node_register(&intel_xhci_usb_node);
 +    if (ret)
 +        return ret;
 +
 +    sw_desc.set = intel_xhci_usb_set_role,
 +    sw_desc.get = intel_xhci_usb_get_role,
 +    sw_desc.allow_userspace_control = true,
 +    sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);

      data->role_sw = usb_role_switch_register(dev, &sw_desc);
 -    if (IS_ERR(data->role_sw))
 +    if (IS_ERR(data->role_sw)) {
 +        fwnode_handle_put(sw_desc.fwnode);
          return PTR_ERR(data->role_sw);
 +    }

      pm_runtime_set_active(dev);
      pm_runtime_enable(dev);
