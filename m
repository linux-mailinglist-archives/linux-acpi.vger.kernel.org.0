Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64EB14A829
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 17:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgA0Qeq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jan 2020 11:34:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38922 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Qeq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2020 11:34:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so8955605oty.6;
        Mon, 27 Jan 2020 08:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u4FSG6+6VmEelxLx4zfzFapuKSQOLzv8NzD+BfIiP0E=;
        b=Zs5iYBmG+dtWLLhFdGvcsPT2EwLhy5t7Y/tsG2f1vL54ximb6InSgWBpwMV4kew51N
         tHESZogyH5WuX3pN7WvSubfLA+zlIw0bdiI0PwDCgWsbmtKA3rk/7b2AoazpkF+yPLhV
         ecIviJukNjcHHckBVymQ8u713hgy2VFfzyvx6o/xq6if4F/ILHjpjq32Uq3MXm4SKL7q
         qWua8K4V27fLnAaniExNvJHMJsc/7ghG1bFT8DA2x7k/VA1ZDJ+nihGu9MEzMjJ62sOL
         PipEbJFhcTBvi36uzYEH25Rir7W3jERuZmANCwWpI40qduUwpo0i8iUus/GMWY83j5kz
         /6vA==
X-Gm-Message-State: APjAAAUHS5LDQlwW7qngtrNj03xulSljD+7EdJMfBj+vU+iORES05pn1
        59ZRXEK9qAUhDckk0nuy2wc4spiHvyQxf1O69LGi+zA/
X-Google-Smtp-Source: APXvYqz6E365gr1xN6liK0FWDMW1TW6v/bSyEt+zWKc/ONA1wMpuMHHRWFNolBlEaZ428RfoiIA7b11guMvKrxkSouo=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr12733646otk.189.1580142885473;
 Mon, 27 Jan 2020 08:34:45 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:34:34 +0100
Message-ID: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.6-rc1

with top-most commit aa811e3cececac2f65f7fa7e17ab46c73d778b2b

 software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST

on top of commit 67b8ed29e0d472bda2f3afe48d6ff99e127eff0c

 Merge tag 'platform-drivers-x86-v5.5-1' of
git://git.infradead.org/linux-platform-drivers-x86

to receive device properties framework updates for 5.6-rc1.

These add support for reference properties in sofrware nodes (Dmitry
Torokhov) and a basic test for property entries along with fixes on
top of it (Dmitry Torokhov, Qian Cai, Alan Maguire).

Thanks!


---------------

Alan Maguire (1):
      software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST

Dmitry Torokhov (7):
      software node: replace is_array with is_inline
      software node: allow embedding of small arrays into property_entry
      software node: implement reference properties
      platform/x86: intel_cht_int33fe: use inline reference properties
      software node: remove separate handling of references
      software node: add basic tests for property entries
      usb: dwc3: use proper initializers for property entries

Qian Cai (1):
      drivers/base/test: fix global-out-of-bounds error

---------------

 drivers/base/swnode.c                          | 154 ++++----
 drivers/base/test/Kconfig                      |   3 +
 drivers/base/test/Makefile                     |   2 +
 drivers/base/test/property-entry-test.c        | 475 +++++++++++++++++++++++++
 drivers/platform/x86/intel_cht_int33fe_typec.c |  81 ++---
 drivers/usb/dwc3/host.c                        |   6 +-
 include/linux/property.h                       |  96 ++---
 7 files changed, 662 insertions(+), 155 deletions(-)
