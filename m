Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5918415658
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFXdM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 19:33:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36516 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEFXdM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2019 19:33:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id z1so382158ljb.3;
        Mon, 06 May 2019 16:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jiP9iD+2z1tpnyhfp3DnXJsTKyxzfB7KXezHFoQBWeE=;
        b=Dabg1rnXhAMilO6gp098nPGH1woRR5oQQogruQk91oRgEkHJ8GwDSITlEASSot1Mer
         4+J/ELqT0Qq3pt823M18K5d7prRI7OjQ4sPjOlyM7sU0H9knXV/hL0LPM4TFcKLXxKV1
         DMDm6Ug3LugOH5/c4vR64NafqrDBZNidvyxL9SLtrjCE90Ds4YGzHPwmNeQck6Y7zhaH
         PFO+x3YQOUzsKMD07ilKEJ3MiSl02RDRx+SbXck7e5CHe82nqEjWZvc/N0yONmiC02wn
         itdqajyseTbuDQGWTl2wD1lQ9TLiUQOX91XSlsVeDNxzFu517Rf4p56iLpgl9ntT0Ez7
         BcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jiP9iD+2z1tpnyhfp3DnXJsTKyxzfB7KXezHFoQBWeE=;
        b=I32w2tUHXKwgv/BCNBHN9pMaMBO6ubCbUXgImeFq5ylhx23LT+tI6DKnJot8wVJnoj
         P5zeQLWZ/B+hwaubKrNtgR7r9Pa91YL/k6rAH/Xr0OOssgFbb4BnP7kBFyxOzyTtBFmr
         QFGKG4m2FragP94KnsNuP6lntpk8ofHWiQ/X9G+3AHSQqXsIMELSDIan53i/myFwlpGP
         Fllo3RHiGPmuBqyjHagQHWOr9t/CzXscDQHtd3tDx0jw8VnjMiGoeTkpW3p+zC98KZLE
         E/Bln1AvIVPVorI7X+7q2hq7Ci/HbiWq6AXp71heANFL/ndexHgUxzbiQ0vitQ3I6JHK
         8eYQ==
X-Gm-Message-State: APjAAAXytdRQmIPf9rY624tTZEJi1ZTMLbAJeK0F7iheePFnuYILOhNZ
        RMwBReAafBEQQptSIcyOz2lzuDEVpESu4sfQGG37V4RkkA==
X-Google-Smtp-Source: APXvYqyGvcGM101HvKgBLwhxy9NE7wSlwXjdLLc8kh4jDLhMmpQKvf4y0sY3WUnjWn1ynctYQjh14fRyWzNY8R7hY7U=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr1310809lja.157.1557185589655;
 Mon, 06 May 2019 16:33:09 -0700 (PDT)
MIME-Version: 1.0
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Tue, 7 May 2019 01:34:28 +0200
Message-ID: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
Subject: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
To:     linux-acpi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

while testing kernel-5.1 I get on one of my Lenovo Laptops very
strange 'ACPI Debug:' messages.

After some grepping I realized these are Debug messages from DSDT ,
however my kernel does
not have ACPI_DEBUG enabled.

I found out the module triggering this, on this Laptop is
ideapad_laptop , but looking at the code
I cannot see what would causes that.

Also on the same Laptop with any 5.0.X kernels I cannot see these.


~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
# CONFIG_ACPI_DEBUGGER is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set

.. dmesg ..
...
[   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
[ideapad_laptop] @ 1322
[   68.026708] input: Ideapad extra buttons as
/devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
[   68.038236] ACPI Debug:  "=====QUERY_64====="
[   68.050232] ACPI Debug:  "=====QUERY_65====="
[   68.060218] ACPI Debug:  "=====QUERY_64====="
[   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
[   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
[ideapad_laptop] returned 0 after 69751 usecssg

...

These =====QUERY_XX===== messages are from DSDT:

~/acpi$ grep QUERY dsdt.dsl
               Debug = "=====QUERY_11====="
               Debug = "=====QUERY_12====="
               Debug = "=====QUERY_24====="
               Debug = "=====QUERY_25====="
               Debug = "=====QUERY_37====="
               Debug = "=====QUERY_38====="
               Debug = "=====QUERY_64====="
               Debug = "=====QUERY_65====="

Also this is the code from DSDT for QUERY 64 and 65:

...
            Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
           {
               Debug = "=====QUERY_64====="
               If ((OSYS == 0x07D9))
               {
                   If (((WLEX == One) & (WLAT == One)))
                   {
                       SGOV (0x02040005, One)
                   }
                   Else
                   {
                       SGOV (0x02040005, Zero)
                   }
               }
           }

           Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
           {
               Debug = "=====QUERY_65====="
               If ((OSYS == 0x07D9))
               {
                   If (((BTEX == One) & (BTAT == One)))
                   {
                       SGOV (0x0202000B, One)
                   }
                   Else
                   {
                       SGOV (0x0202000B, Zero)
                   }
               }
           }

...


Any idea what would cause this ?

BR,

Gabriel C
