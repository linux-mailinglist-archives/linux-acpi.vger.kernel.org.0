Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876C5342164
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSP6d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 11:58:33 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38502 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhCSP6L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 11:58:11 -0400
Received: by mail-ot1-f50.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so8981504otk.5;
        Fri, 19 Mar 2021 08:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k+llNw5yUHajR0BEXiemzUiZNaPM872V8FseEszkL08=;
        b=JYbZQGg7xDMVn2WQzc24nV0ulOy8baCGun8T1Se+9RSs/B7ISV/BphcQDsi6UOQKs3
         8VSGHfREer1UTh/+9D41zM0qGYaUuaTBypR47nfQcKCx/HxYbCk2ApSKwytHKF/rQNzR
         F5cua7avddbisWZHzHHoW2dlhwzuwhlZEQnMQPA0Q7hrw3nPMOcqy8owKzgSqFTEY4bV
         b5trpJiGCR+uAQUezK+ETDdzJ2XA6zYj0pmTTFmNdAb0kXwPxy5trVaiGSaB3KY3BpOC
         c0unQfgauHU5qeREbLMsWr/Dz8h2XVk3mT1sLbXngve1T1DCiLW58UoetZ/Wq+XuBEUj
         Sheg==
X-Gm-Message-State: AOAM533o0y4ipg0q3p8n6eAzke4cmZnry7qRJFcoGU/OlzJwrUhtMwou
        0/HrjS7fUz9o+5oaLeZN0K3zUqfFQi4vuO3BhxZxTu83HP0=
X-Google-Smtp-Source: ABdhPJwZAkOzqUL2IyC85Hu3eceffM1EgT/46r4CqPkrBY/L4zg2hNOSEDptGMR0aT/nckoVPnsp3rVY+y/eilK3tmc=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr1639444otq.260.1616169491165;
 Fri, 19 Mar 2021 08:58:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 16:58:00 +0100
Message-ID: <CAJZ5v0hES51MM9J5nM+An_ON-rxRJ5s_9KCa9n7Fe9nWFziLeA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.12-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.12-rc4

with top-most commit 49cb71a77ce760f20487c38f891aa3132bef782e

 Merge branch 'pm-core'

on top of commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0

 Linux 5.12-rc3

to receive power management fixes for 5.12-rc4.

These revert two problematic commits.

Specifics:

 - Revert ACPI PM commit that attempted to improve reboot handling
   on some systems, but it caused other systems to panic() during
   reboot (Josef Bacik).

 - Revert PM-runtime commit that attempted to improve the handling
   of suppliers during PM-runtime suspend of a consumer device, but
   it introduced a race condition potentially leading to unexpected
   behavior (Rafael Wysocki).

Thanks!


---------------

Josef Bacik (1):
      Revert "PM: ACPI: reboot: Use S5 for reboot"

Rafael J. Wysocki (1):
      Revert "PM: runtime: Update device status before letting
suppliers suspend"

---------------

 drivers/base/power/runtime.c | 62 ++++++++++++++++++--------------------------
 kernel/reboot.c              |  2 --
 2 files changed, 25 insertions(+), 39 deletions(-)
