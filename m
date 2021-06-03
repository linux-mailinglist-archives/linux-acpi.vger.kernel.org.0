Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A248A39A924
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFCR2s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 13:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhFCR2r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 13:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622741222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KIoyaerrgKJKW1OKnBtuGaFHoyJoX4cev0N65O5od8Y=;
        b=AKPuhPMtexur/XjkKQwsSpRM7pxRCM3niOdEHTSVd0mTm5hDCMHYfEeIS4bNHJlhctrgO1
        Cro+2PKFCm8Uxn6K8snT7nUAScqhRcCtMzp0hAGvy6g1U37206WMXGnQZDNRexBGfzdk+T
        IKq4gmHU4k9X4GTKULSjuKTB0sxCddc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-j97WrizZMeS9Yj9u9_bE6w-1; Thu, 03 Jun 2021 13:27:01 -0400
X-MC-Unique: j97WrizZMeS9Yj9u9_bE6w-1
Received: by mail-ej1-f71.google.com with SMTP id b8-20020a170906d108b02903fa10388224so2217372ejz.18
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 10:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KIoyaerrgKJKW1OKnBtuGaFHoyJoX4cev0N65O5od8Y=;
        b=JNP7GaW2PEY+3Q9eqXNaMpIW2QVgG7bzHeuvEudovdjXRbz8x9Av6rdcVoEak5lkoW
         3IGv6jTbvuH3P1fr9K4akLuxwKXlnrdP4R9yVgEsaLTBq05ePBlr/9A7hYCVCHHmwhYK
         jSwsqirk/kIqqFhXda0thx1DDXj6X1Au86TdtbDk0d+XRrTId3nfrtsu4CC4t2aE2/cz
         SQS9rWd1hGjE4PkCUFySF+USnd1mmtRF06PJEeXUcZiCP7dUR44Ep5yLJ/QgecTNXACI
         MbFD9KMFAArXIgBIc1RjToyRKd7M5PnoMJpplT2yuCwQEEx4wFzEzjrqAGergc9nvrG+
         CjGw==
X-Gm-Message-State: AOAM5327zqsmwyp0AIrhyLSYtv69PZSPEND2WGBhT7hgdlRq3WzMPiGl
        R5QZveL5RyOq/+DyAzb3bpAK+N6RAAT6Bpd9kMdroJF3QGhu2u7Tw0x5Qs0oLLp1OIYCLfujXjt
        th4jmtPxXc9l/44I5tHi700f8ObYDWdzvVPl7ciaELmwaOAeFLbxA9+148xnvQH8tSyojTRbNDg
        ==
X-Received: by 2002:a17:906:f849:: with SMTP id ks9mr425729ejb.402.1622741220190;
        Thu, 03 Jun 2021 10:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhW2l9Xa70Rj3EqzN+1G4QRoG+YiZzcPYsY+C/Y+gg6odfgYCOeN/drc0mqWUmh8+FLvgWCw==
X-Received: by 2002:a17:906:f849:: with SMTP id ks9mr425712ejb.402.1622741219939;
        Thu, 03 Jun 2021 10:26:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id l8sm2050324edt.69.2021.06.03.10.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 10:26:59 -0700 (PDT)
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Some SSDT tables are not loading with kernel >= 5.12
Message-ID: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
Date:   Thu, 3 Jun 2021 19:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

I've been helping some users with trying to get to the bottom of some
new ACPI errors with kernel 5.12, see:

https://bugzilla.kernel.org/show_bug.cgi?id=213023

After looking at dmesg output; and after editing the dmesg output
a bit so that I could do diff -u on it, the following stands out:

--- dmesg_5.10.38-1-lts	2021-06-03 16:29:41.372922210 +0200
+++ dmesg_linux-5.12.5-arch1-1	2021-06-03 16:30:01.013031634 +0200
@@ -92,7 +92,7 @@
 ACPI: IRQ9 used by override.
 Using ACPI (MADT) for SMP configuration information
 ACPI: HPET id: 0x8086a201 base: 0xfed00000
-ACPI: Core revision 20200925
+ACPI: Core revision 20210105
 PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096 bytes)
 PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff] (7274496 bytes)
 ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
@@ -113,10 +113,6 @@
 ACPI: Dynamic OEM Table Load:
 ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
 ACPI: Dynamic OEM Table Load:
-ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
-ACPI: Dynamic OEM Table Load:
-ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
-ACPI: Dynamic OEM Table Load:
 ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL 20160527)
 ACPI: Dynamic OEM Table Load:
 ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)

Note how for some reason the kernel is no longer loading the Cpu0Hwp and
HwpLvt SSDT-s ?

Do you have any ideas what might be causing this ?

Regards,

Hans

