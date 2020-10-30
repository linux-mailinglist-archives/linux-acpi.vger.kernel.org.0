Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877262A0B27
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ3Qbp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:31:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42893 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3Qbp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 12:31:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id w145so1565657oie.9;
        Fri, 30 Oct 2020 09:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3wX/pTr7TfWtrHkaELtdk64znGtvJh2O2PtMMtkmtIA=;
        b=BHWa2MKuJguhcdXNTt1JonKpQPpChh5MNzDTt2xvxTgFfp0Dlol/b2RMEe6TKcRuhK
         R2ti7Fa5L7yUbQc+1AdTNx7eJ+Zp4ZoNbh4jvp6pkBsGgM6Tmdh2hF2/iGiOvzmh9set
         MRev8YO4suunVgZ67qKjBjpNsg12ovipcIrSX+Psyy585mSMLFwCJ120e8omaVOBgzl4
         eQn+auLaYMNKeVBiPYN/rdQYaVEibNG4Y4uT3hmUI+AU/6IhwJV0HCdVb4TINsiRCnju
         E5ZmvO6MC6EzZA2niMCP4yJn3oAu3N6YPEMrFh202rYlPVEHWWZmJ5kVfqe7aWvDH9i9
         MPgw==
X-Gm-Message-State: AOAM531mv3SjriO3GbEeNWLUtiCldROUWWt0bVlEJTtPrwfZfC9Gji4W
        NzLRAbq9WjZy+wQdHvwYPqoXR8TnK5w8dcmjfO8=
X-Google-Smtp-Source: ABdhPJyVFqWo8xe6+6bSHR6JFttN0joIgYrJvbOA4qiZCOUa827FEPtaXYOb+Jha8+KdQDfqOALvZMDuJ7jLoxs2noU=
X-Received: by 2002:aca:4c86:: with SMTP id z128mr2289201oia.71.1604075504691;
 Fri, 30 Oct 2020 09:31:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 17:31:33 +0100
Message-ID: <CAJZ5v0h+-s3yazW079SVeLV+Bb7=bN90_1VxXSPeDJqmPtd09A@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fixes for v5.10-rc2
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
 devprop-5.10-rc2

with top-most commit 99aed9227073fb34ce2880cbc7063e04185a65e1

 device property: Don't clear secondary pointer for shared primary firmware node

on top of commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec

 Linux 5.10-rc1

to receive device properties framework fixes for 5.10-rc2.

Fix the secondary firmware node handling while manipulating the
primary firmware node for a given device (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (2):
      device property: Keep secondary firmware node secondary by type
      device property: Don't clear secondary pointer for shared
primary firmware node

---------------

 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
