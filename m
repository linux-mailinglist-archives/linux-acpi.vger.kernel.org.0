Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38B41DDFB5
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEVGPC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 02:15:02 -0400
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:39864
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgEVGPB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 May 2020 02:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590128099; bh=TAVf4jLFj8hT93cLxFB2ku0ce4ryvmgCGGM8l62q3zE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject; b=UiRdiQTFiW7tVzHZ022I8wtnNxxJbEokCsinsffL9qfeYZyh3Qf/I9A5ZPn3cehStnj6Ej4nHqAm7MeC5O6iJUoeTpoUlfeq8QnV6qMG5637WHdrxNd/zaBf196M7aRxNp1dOUPdgSoFQOSuRe66/iD5a+432AAEAROJ1GpZBF4mK+1L5xMP4IHmnkveWZW4i5dg4QmhB2qfPJV2vzVyycaIDm2Z14oAz+PSCk26N71PEXyhmQRsMA8h2XuUML9lw5f3VqMEWqKfL7/JbwMYw6VUXI6X9oTePOOWzonl/Z1PeJFjyq1YdJXSJBtZ81Q1yvAP9WnuyBkAJhC4NTOEpA==
X-YMail-OSG: kRQ8Mz0VM1m6VpfxRRwtqAVww98eAztiT6OTjsqtkEOCLzTkd3z2RFPEYhWhiNS
 gimOg5aZjrfMg2uuJ6B1qWXBVGVGWaiklte0a4gBYbmAayWxO60qyxnLFPvok1mJFqSYM7__tNFW
 .Qi.KPcpI3I3gTeaTL4bPQyqsj2ewurQ98ON9yTcq3w_BR4Q5cDUQ8c1Xcb0oBAKk13XyWNfcBQc
 7K28biewJGPki0nXYlVOFVsbiyGNjhyBwmFwiOslfQmdx6kRpBVShAl8swYqmOcRzflN.Arz16am
 G5VY5JvyuTAC9.hRh5bFvW6QRiM7GAW_jQQVj7wiyMHCBozaNHhbDp6L_HNA8kYXFe9aLJ9T1oMz
 XY3ewxndE6barxpLf12ZD96wlDHjnm511B7pJVv.dojRPvdUkN5QOdbmXf4a6.RTELtmoonPFoyy
 6oLI.e5daAnj.6I2NAUytpzHtzfcklXShBN6LuEjPP3ya76vf0WqbTuR4pkFZ5IL0z7SekTSyq4N
 S4MqVBG.KAvh.lPMOJMnabWMFILfoMBJ7ZDCYvnF5ljn2zuYnnUi7e6iMiZI69mpzhTBZqRkBch7
 S_1IjOlO1BRXHSqEoECjoXmPMzS4QaoueXzm32_HbWNCI7Cpz3NuJ5IQv8__00W.Utgx037jyQgO
 d_px8FWtBxKiusJd6la3F.BEAjf_yzmC.BdBX8arYaGKKIe2cPcIvQW1a38OguM1iW.R7u3zn2Mc
 P746Do.AVK_gOWUHUl7eRcaAnuTzC5X5j7NSDvovbpaTIUobqLKnZBiFiDYbY0VIL.I8iLYgd9EK
 tNwUtfnqSTcQTF8CyAaYG9IKoc4DjSPTU4YYzx3TbNovTIS8k86kfIVHa5ZFD9dpguMyG0CLz8Ic
 LZ0AmSRnMcVCbdWCPASkREoBMKhpJWiNSbQ3q.wW3fqMmtta7mJ2S90f23_4r4z1oAuGUCXwbgtQ
 L3oUUV8PpzQI03Z2Tw0Vz1Pf.4xgbq1Z3L80FrNcMblj.FpOK1YAEcdgZz9bH7.kCz_X31EFFM.g
 wWUPSf0f8AjlLkhxeYNzR9QUUzShmIAPtKEXw9ICVuzco5Hd0t95aJIGkVCVzQLFVklZrMzZDueq
 ExHynApEgu2iJgNBq3I4ml7N_LCjXwhWTBL3ccqxzMNdDEDw8CzYNFRtA8Ok0rHkq_5suK0dELKp
 dULhaP7_rUpKRKUg046WB_5a740dqg6rwXGBgbo1KF3mnQ4MGdmt3zvKNLduqoJY1kWX6m_IU2gq
 PoPbxjy1gFhfPYXyxsZ5OIGqgDxr4wn3N1PIq8HBPAvyPfRFzzPknIwgHNSNgaLn_dxQDpt0AeeN
 e1bFiY.5kAuPhsMM8gK3pxkdVln2e2DN26w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 May 2020 06:14:59 +0000
Date:   Fri, 22 May 2020 06:14:59 +0000 (UTC)
From:   "larsh@apache.org" <larsh@apache.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Cc:     "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Message-ID: <193598853.2172716.1590128099214@mail.yahoo.com>
In-Reply-To: <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com>
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com> <1505028180.591737.1589564161284@mail.yahoo.com> <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com> <2952287.p5mUHPKNZq@kreacher> <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering
 deep sleep states
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.15960 YMailNorrin Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks David!

With this I tracked down the SD Card Reader (Genesys Logic, Inc Device 9755=
) as the culprit.
These are standard in many ThinkPads.
The curious part is that resume from suspend (S3 or S0iX) also fixes the pr=
oblem.
Looks like the driver is not initializing correctly at boot time.

Transcript:

$ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
SOUTHPORT_A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x88018c01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 1024=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 327=
68=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Non-Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x9f409f4=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x88aa88aa=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 174080=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 174080=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Non-Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0

$ lspci -t
-[0000:00]-+-00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-01.0-[01]--+=
-00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \-00.1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-02.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-04.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-08.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-12.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-14.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-14.2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-15.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-16.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1c.0-[53]---=
-00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1d.0-[02]---=
-00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1d.6-[52]---=
-00.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1e.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1f.0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1f.3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1f.4
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-1f.5
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \-1f.6

$ lspci | grep 53
53:00.0 SD Host controller: Genesys Logic, Inc Device 9755

$ cat /sys/bus/pci/devices/0000\:53\:00.0/power/control
auto

$ echo 1 > /sys/bus/pci/devices/0000\:53\:00.0/remove
1

$ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
SOUTHPORT_A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x8010c01=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Non-Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x9f409f4=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x8c548c54=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Non-Snoop(ns): 2752512=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 2752512=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0
SOUTHPORT_E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LTR: RAW: 0x0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Non-Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Snoop(ns): 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0

Cheers.

-- Lars








On Tuesday, May 19, 2020, 9:03:53 AM PDT, David E. Box <david.e.box@linux.i=
ntel.com> wrote:=20





> > > Does anybody know what's going on or how to debug this further?
> > > As stated above, I was able to work around this problem by
> > > ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> > > There has to be a better way, and I'm sure I'm not the only one
> > > running into this.

ltr_show shows the PMC's (Power Management Controller) view of SoC
devices and busses. The SOUTHPORTs are the PCIe root ports on your
system. When you run lspci they are the PCI bridges. Generally, the
bridges are enumerated in the same order as the SOUTHPORTs, so
SOUTHPORT_A is your first bridge and the device attached to it (shown
in lspci -t) is the device that was blocking deeper PC states according
to your debug.

Determine what this device is on your system. If the ltr was low it's
because that is what the device requested. You should first check that
runtime pm is enabled for the device. To do this, check the control
file in /sys/bus/pci/devices/<SSSS:BB:DD.F>/power, where SSSS:BB:DD.F
is the enumeration of your device as shown in lspci. If it is 'on' then
runtime pm is disabled. To enable it echo 'auto' into the file with
root privileges. Enabling runtime pm should allow the driver to reduce
functionality of the device when idle. This should lead to a larger
latency request on the PCI bus which should be reflected in ltr_show.
You can see if the device is actually runtime suspended and how much
time it's been suspended (or active) by reading the associated files in
the power folder.

If this doesn't work, then it's possible that your device doesn't
support runtime pm. This may be purposely for reliability reasons or
the driver may just lack support. Check forums discussing issues with
the device and look for possible options in the driver to force pm
support (generally this will be centered around enabling ASPM).

You can also download powertop to see the package c-state residencies
more clearly as percentages of time. powertop also has a tunables tab
that will show the status of runtime pm on all devices on the system
and allow you to enable them individually.


David

