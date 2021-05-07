Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9F1375F06
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEGDMm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 May 2021 23:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEGDMl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 May 2021 23:12:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6EC061574
        for <linux-acpi@vger.kernel.org>; Thu,  6 May 2021 20:11:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p12so9747242ljg.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 May 2021 20:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6b3rwkaT+yulJoVppL8OpzlcaZY3Q/wrU3tKkCsSBnQ=;
        b=As8j2PlwW3igHwNlqOjj0QbliWX2TL2kI6JcPh7Edyy0MJMT94cJyf7iNWjZGj27z4
         /cdo7Te8QVBNPdSn53scAOfSJqju+DZL/NyxsVubXle/i+0SOBhktyxXASL7rz5OSlAZ
         if5o4S1vLUL/fUrV3K7zcS7q+QtLsZ52atxMB3UoyzvsZztrIVqk78UE1FdJYxYvFOBQ
         5d5C+4krcVwptGMOjsk7a0TVbIcVnoyDJsXOipl5927QNMkRiR3tsho94w5usW88pzFq
         CF3tp4pCsngCmtSSdkmV0JpvFE7F7Vq4zHWWy0ZkxXWpcnjQLhS4MtEXRYDnz1E7dCP+
         vpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6b3rwkaT+yulJoVppL8OpzlcaZY3Q/wrU3tKkCsSBnQ=;
        b=Tjq1zRaaMpJyda8O1N7uX210aKIGbkiVMMiZMk5d0jYzFKcey136p7aydvk5S4N/Z/
         NC6BakLIU9DXx8JyXq+R6Ak5+7WagJn+O72RSB43CfGtx76x49vrpZuw4PyTcyvX0miO
         uAI8us9uw3VjrOz5caQ71/SBkfkU5BELjQnSKRn2ukYHzcH8tZu60fmQX3gKYTEh0uUH
         mwBsE85uC8EoiQwKcwgoBlJuxxEtGG0P6gPmkoA+sZNTjePik5SVDbDRzts/3Pp056Ik
         qUIsnpt2xP5RlpWpKf+u772oKgk+mvacfNQgGoE9AB899m9IlGMXpOQQVWD5lylSPR5U
         Lg6w==
X-Gm-Message-State: AOAM532SK6bRLzj7Z8skvB5XxHhETEUs8myEXBBfuIfDodZaNMBLntya
        RIw+q192uO8Zg5ammDT5h/QjZM+YwH6VtSPZM/k+/WIfv4Cxaw==
X-Google-Smtp-Source: ABdhPJw+voiXuM29E/dKFPmkgQMJK28p8btNNr7A2mVhiVTxNU79bq3AUJWpTCw15otnO5/9nsww0i2ByUHgzWA68KQ=
X-Received: by 2002:a2e:1608:: with SMTP id w8mr5923743ljd.506.1620357100433;
 Thu, 06 May 2021 20:11:40 -0700 (PDT)
MIME-Version: 1.0
From:   Chris McCrae <chrismccraeworks@gmail.com>
Date:   Thu, 6 May 2021 23:11:29 -0400
Message-ID: <CAN2W0iOnPRqX_=vT1BgrRtXHQK0x3am68OuHqSvpzLt4j=JtRA@mail.gmail.com>
Subject: Asus PN62S - CIR ITE8708 device definition in DSDT
To:     linux-acpi@vger.kernel.org
Cc:     Sean Young <sean@mess.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This message stems from a longer conversation started in linux-media.
I thought I'd shorten that story, and just get more to the point.
After a couple weeks of investigating, and a steep learning curve,
I've decided my issue is the definition of the integrated CIR in DSDT.
As originally written, the kernel does not correctly detect this
device, and the correct driver does not bind.  It creates folders in
/sys, but the device gets connected to skl_uncore.  Setting pci=noacpi
allowed the driver to connect properly, but obviously opened the door
for other issues.

By changing _ADR from Zero to any other number (I've tested 0x01 to
0x0F, and they all work), the driver is properly loaded.  Booting from
a custom DSDT solves my problem.  However, I'd like to help other
people avoid this problem altogether by providing this fix to Asus,
which will hopefully make it into a future revision.  So this leads me
to why I'm posting here, asking people who know far more about this
than I do:

1.  While this fix seems to solve the problem, is it possible that
_ADR should be Zero, and something else has the wrong address?  PCI
bridge, PNP, motherboard resources ... these are all areas my
debugging took me, and my understanding of these inner workings is
still not solid enough for me to confidently say the device is wrong,
and everything else is fine.  Are there other areas to
check/test/debug?  I could just tell Asus that this works for me and
let them figure out if it's the right fix, but since I've come this
far, part of me wants to be sure this is the correct solution, and
understand why.

2.  This seems much less likely, but Is it possible that DSDT is fine,
and something on the kernel side has an issue?  I was never able to
trace when the kernel gets the data and makes the driver decision ...
too many kernel options, not enough buffer space :-(

3.  Is there a practical way to provide a technical issue like this to
Asus?  I could try the basic support email address, but I don't know
if something like this would get passed on correctly, or ignored.
Since people here have likely encountered this sort of thing before, a
more direct approach might be known.  Maybe someone here works for
Asus ... in which case you'll be happy to know my PII motherboard
(P2L97) still works if I need Windows 98 for anything :-)

I can provide lots more info if needed.  Thanks.

Chris


    Device (CR00)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (VBAN, 0x0680)
        Name (VIRQ, 0x0A)
        Name (UIDN, Zero)
        Name (_HID, EisaId ("ITE8708"))  // _HID: Hardware ID
        Method (_UID, 0, NotSerialized)  // _UID: Unique ID
        {
            Return (UIDN) /* \_SB_.PCI0.CR00.UIDN */
        }

        Method (_STA, 0, Serialized)  // _STA: Status
        {
            If ((CIRE == Zero))
            {
                Return (Zero)
            }

            Return (0x0F)
        }

        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
        {
            Name (BUF0, ResourceTemplate ()
            {
                IO (Decode16,
                    0x0000,             // Range Minimum
                    0x0000,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    _Y10)
                IRQNoFlags (_Y11)
                    {}
                DMA (Compatibility, NotBusMaster, Transfer8, )
                    {}
            })
            CreateWordField (BUF0, \_SB.PCI0.CR00._CRS._Y10._MIN,
IOPL)  // _MIN: Minimum Base Address
            CreateWordField (BUF0, \_SB.PCI0.CR00._CRS._Y10._MAX,
IOPH)  // _MAX: Maximum Base Address
            CreateWordField (BUF0, \_SB.PCI0.CR00._CRS._Y11._INT, IRQ)
 // _INT: Interrupts
            IOPL = VBAN /* \_SB_.PCI0.CR00.VBAN */
            IOPH = VBAN /* \_SB_.PCI0.CR00.VBAN */
            IRQ = (One << VIRQ) /* \_SB_.PCI0.CR00.VIRQ */
            Return (BUF0) /* \_SB_.PCI0.CR00._CRS.BUF0 */
        }
    }
