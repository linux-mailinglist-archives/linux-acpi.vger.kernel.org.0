Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1F401A80
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Sep 2021 13:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhIFLV5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Sep 2021 07:21:57 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:54537 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhIFLV5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Sep 2021 07:21:57 -0400
Date:   Mon, 06 Sep 2021 11:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630927249;
        bh=FKpXFSCsaSrL/vo02fNpSCQ04k0SNKer63KKba4Fprc=;
        h=Date:To:From:Reply-To:Subject:From;
        b=GBakJtjtx48BHwi0vZkPpNd3tBkXxrYZHXD74s5zrfrkCgjYNIf7wzModytcKkqpg
         ueG7i/On8r+dWyIRZTtpY4IapLtrwSSUaHvFp5khani3rhM5AcFZA9PnDk2cmsw9Mw
         GUvtwbBelSJiIy4VOO1qbK0sr9vXoRXhZFsJkUMY=
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From:   EpicLemon99 <EpicLemon99@protonmail.com>
Reply-To: EpicLemon99 <EpicLemon99@protonmail.com>
Subject: ACPI errors on Linux distribution ISO boot up
Message-ID: <eq3N7LWgv7nk-rKFg758nzHoA9q_iVmK3pZ9XiiWqDKTS-0W0hqxRSK1CiAYI84PiY-APIfnpdTofQqewqjLOKfJoHmCwOg4et9AXnAl4ys=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I have problems trying to use Linux distributions on my new machine, a HP P=
avilion TG01-2856no. The CPU it has was released Q1 2021.

My problem is that whenever I boot a Linux distribution ISO, it appears tha=
t my CPU stalls on tasks, and I get this error:
 ACPI Error: Needed [Integer/String/Buffer] found [Device] 00000000d0fa616a=
 (20200925/exresop-388)
 ACPI Error: AE_AML_OPERAND_TYPE, While resolving operands for [OpcodeName =
unavailable] (20200925/dswexec-431)

The most recent kernel version this has happened on is 5.13.13, with Arch L=
inux.

I could get journalctl logs from NixOS: https://ibb.co/album/9wMM0p

The fact that I have the same problem on multiple distributions has led me =
to believe that it's something to do with the kernel or ACPI, but I could b=
e wrong.

I have set Secure Boot off in my BIOS settings and the SATA emulation is se=
t to AHCI. I have tried with RAID.

I have tried the following boot options: nomodeset, noacpi, noapic, acpi=3D=
off.

The only distributions that I have managed to get working are Devuan and Ge=
ntoo.
