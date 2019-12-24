Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32E129DE1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 06:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfLXFpi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Dec 2019 00:45:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46936 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfLXFpi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Dec 2019 00:45:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id l6so6387421uap.13
        for <linux-acpi@vger.kernel.org>; Mon, 23 Dec 2019 21:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9cLC/DdTewtQ6VoWC50iUnpSvA4UYRuOQ41XFIsGpec=;
        b=m2HK3RlXkMIIE4SGPOHIMc8+GZuljo6wovxXTqF4C7YTAv/zTT52tN0GceaujdQTtg
         83v5kPR+VIglDx76MT/M7Ls+eks3JHEy7YcByvg2GJ73LVwKWUYT6F6E22KkKWcS7v4/
         PfmGGvAVMRWGW5+7FGIz0QVj6vBxN5v4vxmIXs1WmkBVutHOWGMAqYIWorWa6X1HZ5fY
         ZO7R4iQKW5mSZ8dJuO1N3U+5ZlGdjUeb+Y9yOGGiYeasu6lmDXfjqueaH6r9jHVIByrC
         PtBz1fOn0Iuz3RA5Oiato9JN3T21ybI1aIDa31ZTwxI0/TH2qK+TTvL7o9dRNDDMHjSO
         QZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9cLC/DdTewtQ6VoWC50iUnpSvA4UYRuOQ41XFIsGpec=;
        b=fqfDjNIr3TOmYH/8VdgtgB1rO5G9VUzgQRdu/2ypUAvucSpoE5CnjY9ebNTNFVt49Q
         E4OSyEXOsFtlZGpuCvrFtOV9xU1swrXzwkjQ9a0gnXG8TYYoKGnv+SOPsPl3VYwPCuVf
         9qxEkpW5A2Y4Cb8XXm1b/oWwgzkij2SIQANpnbEQBTiXx/+nptVH8WvJqr2pAr6NGG0R
         IYYvpldsZ47cD7m4l/cjYbxWQpume1Fr+amq5ui84l+X/KcOWsJK9q3GuTU5WcT6QLOD
         l+MVBLS4rANMLd8XwaOjGKX3vub/INC5HBc3RGc1q995EzGA6/5CFIaEeaYQ/uf/833a
         dzXQ==
X-Gm-Message-State: APjAAAWdsM6EIstjqvrSESMofJrRIr2V3/3ss/FakRT6Dcz2azyFCo8S
        dn53iqadP4kA2N0tUr4XYJkMW4XQLcNmQvw1pdvnVYFl6Q4=
X-Google-Smtp-Source: APXvYqx+0CeaQkjFm5pbm354ybX3UW2nKIQkXyg/b7xXRND/iPNNJIM/u92larYX8EKd5nnCQMFW6SMwryhIleKF3bY=
X-Received: by 2002:ab0:4aca:: with SMTP id t10mr17013404uae.89.1577166336611;
 Mon, 23 Dec 2019 21:45:36 -0800 (PST)
MIME-Version: 1.0
From:   Anatol Pomozov <anatol.pomozov@gmail.com>
Date:   Mon, 23 Dec 2019 21:45:25 -0800
Message-ID: <CAOMFOmXWFg-5X_4BKDnEQ9NdBmYgxJwuMfX+j5f4Gh18z0Lp7g@mail.gmail.com>
Subject: 2 power buttons detected at ASUS PRIME Z270-A
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello

It is a followup for this Arch Linux discussion
https://bbs.archlinux.org/viewtopic.php?pid=1879144#p1879144

I have ASUS PRIME Z270-A where I run up-to-date Arch Linux with 5.4.6
Linux kernel.

For some reason they system detects 2 power buttons and that it turn
(i think) messes with my systemd logind.conf configuration.

I am trying to figure out how come the system created 2 "Power button"
event files. And what is the way to fix it.

Here is dmesg content:

Dec 12 10:22:52 archlinux kernel: input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
Dec 12 10:22:52 archlinux kernel: ACPI: Sleep Button [SLPB]
Dec 12 10:22:52 archlinux kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
Dec 12 10:22:52 archlinux kernel: ACPI: Power Button [PWRB]
Dec 12 10:22:52 archlinux kernel: input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
Dec 12 10:22:52 archlinux kernel: ACPI: Power Button [PWRF]


Here is a content of /proc/bus/input/devices

I: Bus=0019 Vendor=0000 Product=0003 Version=0000
N: Name="Sleep Button"
P: Phys=PNP0C0E/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
U: Uniq=
H: Handlers=kbd event0
B: PROP=0
B: EV=3
B: KEY=4000 0 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=PNP0C0C/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
U: Uniq=
H: Handlers=kbd event1
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0000 Product=0001 Version=0000
N: Name="Power Button"
P: Phys=LNXPWRBN/button/input0
S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
U: Uniq=
H: Handlers=kbd event2
B: PROP=0
B: EV=3
B: KEY=10000000000000 0


And here is decompiled content of DSDT
https://gist.github.com/anatol/8654b031acfe9c9964bd1974b2892d3f
