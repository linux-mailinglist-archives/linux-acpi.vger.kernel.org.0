Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9570D2BC20D
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Nov 2020 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgKUUat (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Nov 2020 15:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728456AbgKUUas (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Nov 2020 15:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605990647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fWX9mK8WRjAqO5l47oYm4WtVGOQRHKQx9ggm3gl8hSY=;
        b=RDCfva5EXVSGQSX2I6NsbdKw8jpS/Redje1c3nzXcmh1TV/rGjZ+gmgNeT9skoHBwd2wG2
        EtcvBTF5UN2qNkNdd7sSff86HG8qmJJA+aB3e8ih5HRBYF9+06dGvWh0JjkyF698Js61oa
        PrQXDjm5S5Y4CZxU58QKAPmCSPzyB/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Jy674qESPt6xKUqv55dIeg-1; Sat, 21 Nov 2020 15:30:43 -0500
X-MC-Unique: Jy674qESPt6xKUqv55dIeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65713809DCC;
        Sat, 21 Nov 2020 20:30:42 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-24.ams2.redhat.com [10.36.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71D171C959;
        Sat, 21 Nov 2020 20:30:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
Date:   Sat, 21 Nov 2020 21:30:33 +0100
Message-Id: <20201121203040.146252-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

A while ago (almost 2 years ago) I discussed an issue with you about
some devices, where some of the methods used during device-addition
(such as _HID) may rely on OpRegions of other devices:

https://www.spinics.net/lists/linux-acpi/msg86303.html

An example of this is the Acer Switch 10E SW3-016 model. The _HID method
of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
the installed wifi chip and update the _HID for the Bluetooth's ACPI node
accordingly. The current ACPI scan code calls _HID before the GPIO
controller's OpRegions are available, leading to the wrong _HID being
used and Bluetooth not working.

Last week I bought a second hand Acer device, not knowing it was this
exact model. Since I now have access to affected hardware I decided to
take a shot at fixing this.

In the discussion you suggested to split the acpi_bus_scan of the root
into 2 steps, first scan devices with an empty _DEP, putting other
acpi_handle-s on a list of deferred devices and then in step 2 scan the
rest.

I'm happy to report that, at least on the affected device, this works
nicely. While working on this I came up with a less drastic way to
deal with this. As you will see in patch 4 of this series, I decided
to first add a more KISS method of deciding which devices to defer
to the second scan step by matching by HID. This has the disadvantage
of not being a generic solution. But it has the advantage of being a
solution which does not potentially regress other devices.

Then in patch 5 I actually do add the option to defer or not based on
_DEP being empty. I've put this behind a kernel commandline option as
I'm not sure we should do this everywhere by default. At least no without
a lot more testing.

Patch 6 fixes an issue with patch 5 which causes battery devices to stop
working.

And patch 7 adds some extra HIDs to the list of HIDs which should be
ignored when checking if the _DEP list is empty from Linux' pov, iow
some extra HIDs which Linux does not bind to.

Please let me know what you think about this patch-set. I would be happy
to see just patches 1-4 merged.

If you dislike the HID match approach I can drop that and add a DMI-quirk
list of devices which need the new 2-step process (for now), to fix those
without regressing the OOTB experience on other devices.

Or we could just entirely switch to the new scheme in one big step, but
that seems a bit too adventurous.

Regards,

Hans

