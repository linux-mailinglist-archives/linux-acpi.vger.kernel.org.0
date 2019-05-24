Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DFB2A03A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbfEXVKr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 May 2019 17:10:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38451 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391765AbfEXVKq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2019 17:10:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id p26so6974481qkj.5
        for <linux-acpi@vger.kernel.org>; Fri, 24 May 2019 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqwnG1uIANfo29FPPFO9XzdxaIL8u/YShBseQ7nZRAg=;
        b=SQ92VKPGzUpQMVWPmzyFFvqntCrKJfUDQ81Kl1fc2lDQ4knAU0wvsoetXOYHQzC5mC
         aM/JAZnnPh/EYJMQRWlUfVk2UwIhyXH1lNN0LU3qXnZjLBul+NnypLeh7o5b4HJkgfj9
         NaJWpGlQqNt5X397cFWigSHMLSIrVHSV+E3/q42XVK+D+pdJQMDMHAYBU1EayTMIgYdv
         QkfDq8h7q+9cj5n2X9diEXG5BmSEJMeZiLoCbo5jdwXGnvE+ooU3nujenKRix/cVslAG
         5GbBpmWX66iMdRFHApqRCoJTb4konvSDaXKPupYgO7jRIVi1WOXtaKuxqduRfE4R9pfr
         DdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqwnG1uIANfo29FPPFO9XzdxaIL8u/YShBseQ7nZRAg=;
        b=Rn6ymZ0yftFHdCWdBLNbrIG8Iy0GWcmVRya0ljrhcQzCkw4svw/Vkoy71sxJm3fsmI
         8oMMhN1ApTpETTaUibt7z4S6w/HLQ3bQRdqUKji0zCjUy18Tdg7hIRox1fzPNLtL5rmh
         CRWUw3kRugccmeJs5hBfMrqGaSrL55j24GHKcf+e8h4FqOQN8nlH5cvUTDUK0+wNOt9T
         TPDXQQUFcFbYRqkAdmia17BNO6x2B3HS4l8N2nqF4qRqXwJCvrMJrWwBkLmqTTjuxqqj
         z5pXiUitb1KXlWxkFuaVZMB9/pOqzox1W9sBXZkv8a76CLmFRfWktUgs6FG3ULFN4zT2
         PsuA==
X-Gm-Message-State: APjAAAVo5/GN4gqBzDXgOZLxNsRH+j4KRPqAbeBnei20XdmuF0QK+0P+
        FrjlmdinJVh8Vpq5YuCflVAa/HBJEPccQWeJodQaPQ==
X-Google-Smtp-Source: APXvYqw53TxiSztmeS5aG/lRAscCWEBCg60ghArjRRHg8ms6Qa8DVfD44TDY+uL/Ii2z9W8E3g1ie46yeMnAfbL/JOU=
X-Received: by 2002:a0c:b04f:: with SMTP id l15mr70291951qvc.191.1558732245610;
 Fri, 24 May 2019 14:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com> <35811fe2-7aac-aa3c-46dc-2bef515b0f47@gmail.com>
In-Reply-To: <35811fe2-7aac-aa3c-46dc-2bef515b0f47@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 24 May 2019 15:10:34 -0600
Message-ID: <CAD8Lp45kFO47N9KpgF4SACLUZmjOEG49_=ZLgP8fZyOYh_qYJg@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] platform/x86: wmi: Add function to get _UID of
 WMI device
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 14, 2019 at 12:59 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> Add a new function to acpi.h / wmi.c that returns _UID of the ACPI WMI
> device. For example, it returns "ATK" for the following declaration in
> DSDT:
> Device (ATKD)
> {
>     Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)
>       // _HID: Hardware ID
>     Name (_UID, "ATK")  // _UID: Unique ID
>     ..
>
> Generally, it is possible that multiple PNP0C14 ACPI devices are present in
> the system as mentioned in the commit message of commit bff431e49ff5
> ("ACPI: WMI: Add ACPI-WMI mapping driver").
>
> Therefore the _UID is returned for a specific ACPI device that declares the
> given GUID, to which it is also mapped by other methods of wmi module.
>
> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

Some extra background may be useful when reviewing this.

As researched in
https://marc.info/?l=linux-kernel&m=155498017207933&w=2, we are
dealing with a tricky situation.

asus-wmi currently serves two different classes of device: eeepci-wmi
and asus-nb-wmi.

The eeepci devices have:
  _WDG : includes a METHOD block with GUID ASUS_WMI_MGMT_GUID, and an
EVENT block with GUID EEEPC_WMI_EVENT_GUID
 _UID : ASUSWMI

The asus-nb-wmi devices have:
 _ WDG : includes a METHOD block with GUID ASUS_WMI_MGMT_GUID (same as
eeepc), and an EVENT block with GUID ASUS_NB_WMI_EVENT_GUID
 _UID : ATK

To support new devices we now need to start concretely identifying
which of these we are working with. But complications include:
 - The main MGMT_GUID used for matching at the moment is shared over
both device types
 - Some Asus products have both of these (via two separate two
separate PNP0C14 WMI devices).

Currently eeepci-wmi and asus-nb-wmi register themselves with
asus-wmi, which registers a platform device for each one. The platform
dev probe then succeeds the platform device probe when it finds any
_WDG entry for the main MGMT_GUID and the _WDG entry for the
corresponding event GUID (not necessarily as part of the same
underlying ACPI Device). In the case of both devices being present
with duplicate MGMT, the first one that is parsed wins, and the other
is ignored (see guid_already_parsed()).

Sticking with the current approach, which is imperfect for devices
that have both devices, adding a method to detect the _UID seems
reasonable. Although actually I just realised you could probably also
detect the difference by using wmi_has_guid() on the EVENT UUID
without having to add a new function.

I'll keep thinking about how to improve the situation around two
devices present (but don't want to needlessly conflate this patch
series with that).

Daniel
