Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA301749D3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 11:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbfGYJ0l (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 05:26:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32923 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388704AbfGYJ0k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 05:26:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so37216431oiv.0;
        Thu, 25 Jul 2019 02:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=w38Ou4OJOlMG5lDoxJ8ldT1Y+XC1NV6l4c49/2DKWfI=;
        b=aPjTa6lZ3dPRvLfbSX7weGuh1z1fvuG/Bc++iPDQ9yMAdpzJRUuzeMVpef52Dywzsj
         nwGWBviRQecrmVql63lNNaNOUtfAyVl/PG+UOAyB5oy7tJ2djRGxK8nWKEk4ygLlMyKL
         mbor11aYv+n70rwETMehWtnyY7v8gx78Uwxr3NNg4ShqEa9Woxabw8Ku+Q57vXc6MHOA
         HuGEPLjDSv/yF1AG766/JjHNDMc+cQh/ciC+ezGmG/BjIavWK72FkN+SCy9yYBJBdz9Q
         qcF10j4lzjZmNcH0PhN/lU52JXrP18H84tsD7l1HJgryRZjz1AT9AkeDhZUOrMuBvgYw
         4htg==
X-Gm-Message-State: APjAAAVERIgtPHV/tnciieUTdfzA4Hnh5N41DunGGz9oHnWAglUDmQlT
        dg1+S0OXeInxBCIr8eFVSSIeT9uN8dlKBwDfzR3+QQOL
X-Google-Smtp-Source: APXvYqydXzzzbK+sslefknnxfPouRbypTTltL5e7dCGlIuW+utt4we8xB7FdEFttPQhKU/MffPLNOP7QQ6ufX5hD2Fc=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr38571220oig.115.1564046799855;
 Thu, 25 Jul 2019 02:26:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jul 2019 11:26:29 +0200
Message-ID: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.3-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc2

with top-most commit fdc75701578269f6931975aebf4069d9d8c77d34

 Merge branch 'pm-cpufreq'

on top of commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b

 Linus 5.3-rc1

to receive power management fixes for 5.3-rc2.

These fix two issues related to the RAPL MMIO interface support
added recently and one cpufreq driver issue.

Specifics:

 - Initialize the power capping subsystem and the RAPL driver earlier
   in case the int340X thermal driver is built-in and attempts to
   register an MMIO interface for RAPL which must not happen before
   the requisite infrastructure is ready (Zhang Rui).

 - Fix the int340X thermal driver's RAPL MMIO interface registration
   error path (Rafael Wysocki).

 - Fix possible use-after-free in the pasemi cpufreq driver (Wen Yang).

Thanks!


---------------

Rafael J. Wysocki (1):
      int340X/processor_thermal_device: Fix proc_thermal_rapl_remove()

Wen Yang (1):
      cpufreq/pasemi: fix use-after-free in pas_cpufreq_cpu_init()

Zhang Rui (1):
      powercap: Invoke powercap_init() and rapl_init() earlier

---------------

 drivers/cpufreq/pasemi-cpufreq.c                   | 23 +++++++++-------------
 drivers/powercap/intel_rapl_common.c               |  2 +-
 drivers/powercap/powercap_sys.c                    |  2 +-
 .../int340x_thermal/processor_thermal_device.c     |  4 ++++
 4 files changed, 15 insertions(+), 16 deletions(-)
