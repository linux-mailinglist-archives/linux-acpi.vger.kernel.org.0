Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41E2B2DCC
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Nov 2020 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgKNPLH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 10:11:07 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:45648 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgKNPLH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Nov 2020 10:11:07 -0500
Date:   Sat, 14 Nov 2020 15:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605366663;
        bh=6xzNE4Du/hs4RHSo2ZzjZfMbfbcDNW0gVbL3US0Blmw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sI/hXGr55StG6ux/7cuK8k61MS+GHcXohhHr9wFwrTv7eOljss271WyXNdCrNd/by
         Sf7hsT6msKSLQa+5UtzIyGVI9lt0FqeVlXy2+pvmzje8jDCHANDxUWMvn+dBskbhfB
         BbPFxl1NXDUlHr2hfnWzD9qMK/jRfev+TsHkFZbo=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <CdK0cja89gyPPQ6zqxRZXa6fLNoyX_H3aMbIZtTEKQx255HoS2gKq6QESJr0f-qXlGVPXg_QFk66LHxrdgfkseCXYuk_SpfGXxx_NE-Jvbg=@protonmail.com>
In-Reply-To: <20201114150102.340618-2-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201114150102.340618-1-markpearson@lenovo.com> <20201114150102.340618-2-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

> [..]
>  drivers/acpi/Kconfig            |  33 ++++++
>  drivers/acpi/Makefile           |   1 +
>  drivers/acpi/platform_profile.c | 181 ++++++++++++++++++++++++++++++++
>  3 files changed, 215 insertions(+)

I believe the header file is missing from the patch.

> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
