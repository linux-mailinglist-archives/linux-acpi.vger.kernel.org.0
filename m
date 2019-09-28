Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E715DC1267
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2019 01:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfI1XMk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Sep 2019 19:12:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41608 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfI1XMj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Sep 2019 19:12:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so3468445pfh.8;
        Sat, 28 Sep 2019 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lNZrzq4ZFFPrX0MTl+M498nYJtUFl4tpzfGqtmJqwcI=;
        b=I9UDzWtG5ZUny0q4yWYmOR4H8K7qYtcnS7BEFTS7vaeVBSKCGtM+qrPgWEtugKT1mh
         SwiW15+gci+ED9BjD1M75oWaIzW6N/c4WYwmn9M/+VQxtO5OKq2la7k+kXVA4rkuN0oI
         PxMAr/z3t/IXwdjUmjr+3IR8nMt8ac3Cmhxh1qkWp1JXd3lfdQ2NuX7X+XFuyqtXSoih
         KL4/0VCuoC80ALHHCRshcZkMqm2SVSF4rTakNY8aNwRVLE0a9ERlEdA68bWgUL/1Jg3f
         OBV4L8y3iyUNTECFiwQzuqdOD2i/PNsY0PhS1bEG+gh1mALjWZj3cMQXS2Kn5vldAJP+
         krCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lNZrzq4ZFFPrX0MTl+M498nYJtUFl4tpzfGqtmJqwcI=;
        b=ckCW7t4xj4DgjyOhV41LLxaB6anQz8E7s4Tzp2LzE/AAn8U2NB8w8WdLqerTW7xCAg
         YvNMlHisp+rLT2zZupqW0HwCxfB1MlKawMDo7sfnyQRDNcWTVhxQiZE9tGQhCWVJfKoz
         U2XlWIV603ROONNe9eBHuTwLvKp5/4IvCOdy9NbZijmglaSXFez/9uHRnbxLHcKPJ0b6
         rP50WbVtBm6RYq6X0z28Sj+wVdn85JWU0sbC/fkAeo6x9h+y3dA/kRKiRbTzGT26A5jw
         9ZhTHgH8WsIqrISTLa65Me49xlyA0OURrNNdQHY9R4oegPy//zcqSfqYMe9NMVDuZb3m
         HyAw==
X-Gm-Message-State: APjAAAWvYVDlafhQzD2bwxwU4FvMTkQxGa9wOTe8sXhZMT0ek+jXa+S6
        UyCkDshBHFzir7lO1pia2EY=
X-Google-Smtp-Source: APXvYqytmRo7xCnVrcWcE5cZXb/tDBqsxGrous6RdG6Jj7jkX/YY7EFEN1bkHopa4BbpOuqRv0qTCw==
X-Received: by 2002:a63:4381:: with SMTP id q123mr16706745pga.169.1569712358821;
        Sat, 28 Sep 2019 16:12:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id s17sm14607186pgg.77.2019.09.28.16.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 16:12:38 -0700 (PDT)
Date:   Sat, 28 Sep 2019 16:12:36 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management changes for v5.4-rc1
Message-ID: <20190928231236.GD7360@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Linus,

Please consider the following thermal soc changes for v5.4-rc1. This is a really
small pull in the midst of a lot of pending patches. We are in the middle
of restructuring how we are maintaining the thermal subsystem, as per
discussion in our last LPC. For now, I am sending just some changes
that were pending in my tree. Looking forward to get a more streamlined
process in the next merge window.

The following changes since commit 56037cadf60461b4a2996b4d8f0057c4d343c17c:

  Merge tag 'regulator-fix-v5.3-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator (2019-09-09 10:58:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 6c375eccded41df8033ed55a1b785531b304fc67:

  thermal: db8500: Rewrite to be a pure OF sensor (2019-09-24 22:59:22 -0700)

----------------------------------------------------------------
Dan Carpenter (1):
      thermal: thermal_mmio: remove some dead code

Linus Walleij (3):
      thermal: db8500: Finalize device tree conversion
      thermal: db8500: Use dev helper variable
      thermal: db8500: Rewrite to be a pure OF sensor

 drivers/mfd/db8500-prcmu.c                   |  53 +--
 drivers/thermal/Kconfig                      |   2 +-
 drivers/thermal/db8500_thermal.c             | 486 ++++++---------------------
 drivers/thermal/thermal_mmio.c               |   7 -
 include/linux/platform_data/db8500_thermal.h |  29 --
 5 files changed, 114 insertions(+), 463 deletions(-)
 delete mode 100644 include/linux/platform_data/db8500_thermal.h
