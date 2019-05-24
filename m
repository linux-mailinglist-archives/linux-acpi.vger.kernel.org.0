Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A52997A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 May 2019 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403997AbfEXNzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 May 2019 09:55:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403976AbfEXNzC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 May 2019 09:55:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so5383433pfn.7;
        Fri, 24 May 2019 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=74cGYuYE4LvrkLIEFnFNyny7NYqRKsZMnpjvNI31MgI=;
        b=UipkAn8uV7zvYKNe8UA7lnIfZMEMxdpw0XyGFfhCgJd67Bhn1WazcJ4fTPuCSKlCnv
         TY1JdY1Y4Wm99qK0+XgTQfByzGK8lFjXlqV/xcE/HPWQvIHfrrkfF9lNnQe3q73pW35F
         8FLITnR5oJQbQOv7Wkjb00tn8Ts2jPOhuDZhMaZ7hFWAMvl2vHf2xBAlbyHWbsnOR74h
         caVc9UZxNuu3x6JJcqqB3SjrGzTwuPlNmzZEokOh+RXw1BnOBfhFjmqxWW0iVaB27zNU
         OJ6+dwr0RBCYI9Q0d0ZKOjlcUo1uaplXKXUoeq+tDW8j5YUuGP+VJRQHcVu3s7eVEWmF
         D6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=74cGYuYE4LvrkLIEFnFNyny7NYqRKsZMnpjvNI31MgI=;
        b=OksJDkWsDr8Dgc+UUfoNUCF01dO96/oLF0S7ICuWlmc4uJpo7kxaNmCVhRSbqZwtXL
         BduscMSAqmq7Hle/v6QlM4J9GwgONs0UNVtAfQxTV1XK9TZE4Wcck8fazig2p9jDUwWe
         QKPdXpEOL6GQaB2I0jVMFlxsKy5YBB9+PsJjVWRJOzqPVsvwAQt7ySECPz560asAXQZl
         gyX3Z6faTTeMYcs9kZADlp1u1I0G+7a008GEOA03CV4983GIf9RHAbENPEp3GxzXlNX0
         ktlEZdvxMFbo+NITNMoWq8dy+2VlM+wd2jQO6osDMvtrJvLHw/BTeZXp7SuUCsKljAq4
         pc0A==
X-Gm-Message-State: APjAAAWTwUktDZPLQPIsQsaTGJZwk+mkUsGI287pJst8tNlfU6grV/pp
        /MGqUlCbMhtlCthRi32KTt8=
X-Google-Smtp-Source: APXvYqyI4/9Own5qAnrvmUJI2kt8z4xs3DQFmq8LiAk+f/vitLhrSqGFqGrT33edFUqBUwdG7Pzovg==
X-Received: by 2002:a17:90a:ba96:: with SMTP id t22mr9617439pjr.143.1558706101263;
        Fri, 24 May 2019 06:55:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id u5sm2193541pgp.19.2019.05.24.06.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:55:00 -0700 (PDT)
Date:   Fri, 24 May 2019 06:54:58 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management fixes for v5.2-rc2
Message-ID: <20190524135457.GB2750@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Linus,

Please consider the following thermal soc fixes for v5.2-rc2.

The following changes since commit 4dde821e4296e156d133b98ddc4c45861935a4fb:

  Merge tag 'xfs-5.2-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2019-05-23 11:18:18 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144:

  thermal: rcar_gen3_thermal: Update temperature conversion method (2019-05-23 21:58:25 -0700)

Specifics:
- revert pinctrl settings on rockchip which causes boot failure on rk3288.
Proper follow up patch being discussed. Meanwhile reverting gets those booting again.
- Minor fixes on rcar and tegra

BR,

Eduardo


----------------------------------------------------------------
Heiko Stuebner (1):
      Revert "thermal: rockchip: fix up the tsadc pinctrl setting error"

Yoshihiro Kaneko (3):
      thermal: rcar_gen3_thermal: Update value of Tj_1
      thermal: rcar_gen3_thermal: Update calculation formula of IRQTEMP
      thermal: rcar_gen3_thermal: Update temperature conversion method

YueHaibing (1):
      thermal: tegra: Make tegra210_tsensor_thermtrips static

 drivers/thermal/rcar_gen3_thermal.c       | 92 ++++++++++++++++++++-----------
 drivers/thermal/rockchip_thermal.c        | 36 +-----------
 drivers/thermal/tegra/tegra210-soctherm.c |  2 +-
 3 files changed, 64 insertions(+), 66 deletions(-)
