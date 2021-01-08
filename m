Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55C2EF6D6
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbhAHRza (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 12:55:30 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39866 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbhAHRza (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 12:55:30 -0500
Received: by mail-ot1-f46.google.com with SMTP id d8so10444429otq.6;
        Fri, 08 Jan 2021 09:55:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XeX1l1nPiNtc5q7NBHuWNuod0L9IFtRRz4+aS3Q/Wn8=;
        b=Id6Dxv8zZYdxAAquGPy9x30G4KjRg9SLA16Ti+rKQHKWMjt5X0Ai7zWX/MalADdSE6
         27DrKjmhf86EpUY9MSr94hLTg+pWDeCLa5j9RJhiDiVHhGz4ylsIH7AivW/rGAZe/F6A
         NPMeHIcffC5KqjRhdTFGdW7ou6wlWr11UNRET65gwcOzCJ9utPuR4MQQ+4EVDUI2y5mX
         fUoA6m6nyafsAk65K1nnPz+OOsw4mx9OJ5cnBD+AQM8RG8wiyXDfkOGImDNMPa9A9/kw
         KDfDzdAUSwk/dv+ulSUdbT3fXBBhfE86BmScqogx6cOuHshOofUV6N4mfxIZ4ih+OiRh
         rKCQ==
X-Gm-Message-State: AOAM530pbioZCDY3cFamZOz6PAmIgFc0QpC1wzRSB8buMLYDKApBqRan
        NsUslPJEctBHV/t/40OALOYCKIaAVPYFpMvc9F8ETYGFDlc=
X-Google-Smtp-Source: ABdhPJwXqe5X1qNT5lcOoAxI+APdjrsiJz8nFSxjZCITJ07HiqOQHygWDMgtsAEYyoAw106FZY7amoWgyuTjtF+QtgI=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr3523364otk.206.1610128489496;
 Fri, 08 Jan 2021 09:54:49 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jan 2021 18:54:38 +0100
Message-ID: <CAJZ5v0h0kagZ6n+xC0wcCN5Zg3=HQ0NS_HO6fC0do8H5BqbD-w@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fixes for v5.11-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.11-rc3

with top-most commit 3f7bddaf5d5a83aa2eb1e6d72db221d3ec43c813

 device property: add description of fwnode cases

on top of commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62

 Linux 5.11-rc2

to receive device properties framework fixes for 5.11-rc3.

These revert a problematic commit that went in during the 5.10 cycle
and iprove the kerneldoc description of the function affected by it
(both changes from Bard Liao).

Thanks!


---------------

Bard Liao (2):
      Revert "device property: Keep secondary firmware node secondary by type"
      device property: add description of fwnode cases

---------------

 drivers/base/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
