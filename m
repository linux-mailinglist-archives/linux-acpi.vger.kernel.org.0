Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41035410611
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Sep 2021 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhIRLcx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Sep 2021 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239081AbhIRLcv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Sep 2021 07:32:51 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EDAC061574
        for <linux-acpi@vger.kernel.org>; Sat, 18 Sep 2021 04:31:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a10so25927277qka.12
        for <linux-acpi@vger.kernel.org>; Sat, 18 Sep 2021 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=l9vJ076MUOUMez6fH7RAAuj9aqmTJIuSHEyRJV470Mk=;
        b=NgEtGjEXLdOgACXd4oF6TXizLmHTc6csVZ3t42PzqRQ8Dtvhpq+V6SqSqWX5+eyBky
         v7owQd1dZ8AbAIcYFFjfQxFyQpktSqIf2XPZVjJCib+xCwXcutwvNBCaYIe8eC+0vq1w
         +9508Q1ap9tlIJzHv5Ac1x1N36cxU0nfduvwzd0DfsuvEUU/4mMdrqWxGObGfuq3Ep/K
         VzPF0doD3lne1z9PnnDjLMyqeFlZ6hTFwwAY312hYZNuxhuvsj/etYkPW+NCKSdsr4Fe
         XyEQAr/ECeZ1s5QalXw3JRJUvHiWCuTDST4WwdOJPK07CMejiPQaaGRVXWFm5e0qnzIa
         izuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l9vJ076MUOUMez6fH7RAAuj9aqmTJIuSHEyRJV470Mk=;
        b=ZqbQpPnoczep42KIpnVLLOmyGSQHH2gDt9Nmgr/yuCgj3e+fQLQyN7Lj4Gn/EwEJ/+
         L95LvsKupL6oIJ09Q2hXtY0RpobFnkIjl4StXvwN+cYagdzxUxrwA7Emg6mztakjfn9y
         1VOgHyj0Ad7CCJJpGwRIZmblFP2gKcsnmC5bXvlIC8BWYc8IeDtIR6FxF/4URoa6JehS
         xZYArTZ7616a5mVkkx65Gr9xO+CjCe9zswEBj9vNaF4pLYufYeXvSn2P/flLtZGzeS9X
         BwKNk5SaqmVmpGa3QMjWVz5ruyW0X247+/iiHalO/ecReIelKHqI8Q/FmZfqtqWvoD/K
         zj2A==
X-Gm-Message-State: AOAM533Zwmypoa0Uurv+0ZARThsfBxHA4HRHTAu4cnnCBY2BjznDsm5a
        Kcp7VHe0Zh+Wni+0UGgOJUZebT344Dk830XXvZbDic9H/vU=
X-Google-Smtp-Source: ABdhPJybo5CppUEFgbOJqwtrKDw62ZIkbuDwvMXGIkMCJuIZxF0YoB+OYTx6Wxc4/3Db7mw7b3Jed98TQuD6UVRvwrQ=
X-Received: by 2002:a25:1584:: with SMTP id 126mr20106454ybv.126.1631964686438;
 Sat, 18 Sep 2021 04:31:26 -0700 (PDT)
MIME-Version: 1.0
From:   James Dutton <james.dutton@gmail.com>
Date:   Sat, 18 Sep 2021 12:30:50 +0100
Message-ID: <CAAMvbhFOYG2dBksLPo1DZdWnUy-vLgL+qiQDH+JrD9VeeYLXww@mail.gmail.com>
Subject: I2C SMBUS SPD ECC DIMM access vs. ACPI BIOS
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On trying to "modprobe i2c-piix4" I get:

[  209.488778] ACPI Warning: SystemIO range
0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion
0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI)
(20210604/utaddress-204)
[  209.488791] ACPI: OSL: Resource conflict; ACPI support missing from driver?

The purpose of this attempt is to use I2C SMBUS to read a temp sensor
on the ECC DIMM.
This same approach works on a different AMD AM4 motherboard, but this
is a Gigabyte AMD X399 Threadripper motherboard.
Now I understand that this warning is a safety warning, because if the
BIOS ACPI and Linux userspace tried to access the EEPROM SPD on the
DIMM at the same time, hardware damage might result.
So, my question is, who should I ask to get enough documentation or
hints, so that I could modify the source code to make this work
safely.

DMI: Gigabyte Technology Co., Ltd. X399 AORUS PRO/X399 AORUS PRO-CF,
BIOS F2 12/11/2019
LSPCI:
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) I/O Memory Management Unit
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 59)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 7
00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 0
00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 1
00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 2
00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 3
00:19.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 4
00:19.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 5
00:19.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 6
00:19.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Data Fabric: Device 18h; Function 7
01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] X399 Series
Chipset USB 3.1 xHCI Controller (rev 02)
01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] X399
Series Chipset SATA Controller (rev 02)
01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] X399 Series
Chipset PCIe Bridge (rev 02)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port (rev 02)
02:01.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port (rev 02)
02:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port (rev 02)
02:03.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port (rev 02)
02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 300 Series
Chipset PCIe Port (rev 02)
04:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network
Connection (rev 03)
08:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Raven/Raven2 PCIe Dummy Function
08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) Platform Security Processor
08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) USB 3.0 Host Controller
09:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Renoir PCIe Dummy Function
09:00.2 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 51)
09:00.3 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) HD Audio Controller
40:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Root Complex
40:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
00h-0fh) I/O Memory Management Unit
40:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge
40:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) PCIe GPP Bridge
40:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
40:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-1fh) PCIe Dummy Host Bridge
40:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B
41:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
NVMe SSD Controller SM981/PM981/PM983
42:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1470 (rev c3)
43:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1471
44:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
44:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10
HDMI Audio [Radeon Vega 56/64]
45:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Raven/Raven2 PCIe Dummy Function
45:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD]
Family 17h (Models 00h-0fh) Platform Security Processor
45:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 00h-0fh) USB 3.0 Host Controller
46:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices,
Inc. [AMD] Zeppelin/Renoir PCIe Dummy Function
46:00.2 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 51)
