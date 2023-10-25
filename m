Return-Path: <linux-acpi+bounces-972-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900257D734D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928731C208D0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239F31A67
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5830F8D
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 17:51:17 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2FA123;
	Wed, 25 Oct 2023 10:51:16 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57de3096e25so5872eaf.1;
        Wed, 25 Oct 2023 10:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698256275; x=1698861075;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0sZrs9MuS+86zDU/MsJ/ZulEyleyOije+QkqQwj6sY=;
        b=loCQFc/IoAzTU1i7oVY4tgK2YzelF0ulrRWSpk8LZ9Fa/kBzhvzuedBYGaLcR1OdL6
         OPP6QvLzVfbLtMLQdasxk6pjZ8LV+wiKFweXZFFSNCpAR6FKLoBZWS2rWEf/zPTK32Rq
         /tvgLjzSpnO20ptR/woE+vvZM/uC0znAuoY0ipTehoEH8rmQdjzYYiRzYuSztTEIRAZn
         RXqXolQNRZG/wHNK5Ng1mICdF+Xy0BdzFxgy9fY5b7SkkkqAABE5UwPhSRb0m3rLPN+b
         OY7/nmLp/Oi54c5K+DBUqF2lwzwV+n1UqaJ75PvDHjOd1CwMo9LnlrbU2y2nHVkSpFNa
         cvEA==
X-Gm-Message-State: AOJu0Ywcj/jObKbARwSbevW1axrFzAE/Zob6aAR3Bi19t+Br+XZZ0Dl2
	5eiDwF+fa7vcmunxST8qTo/cFW0yszE+rz/faNc=
X-Google-Smtp-Source: AGHT+IFCA0SEdK9m8vSIvw85EgwaejMKhBk+2eajXLIBFquGyYGfOy8NuRsSUt4oLKxAESlfJ86CeK7wYlYQ0T/EOxM=
X-Received: by 2002:a4a:bd18:0:b0:581:e7b8:dd77 with SMTP id
 n24-20020a4abd18000000b00581e7b8dd77mr17606973oop.1.1698256275473; Wed, 25
 Oct 2023 10:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Oct 2023 19:51:04 +0200
Message-ID: <CAJZ5v0hQGLq6JdJqVnhF_-DqXTjHubrt7khJi_ZoDU0diNTPMQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.6-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc8

with top-most commit 9b311b7313d6c104dd4a2d43ab54536dce07f960

 ACPI: NFIT: Install Notify() handler before getting NFIT table

on top of commit f20f29cbcb438ca37962d22735f74a143cbeb28c

 Merge tag 'acpi-6.6-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an ACPI fix for 6.6.

This unbreaks the ACPI NFIT driver after a recent change that
inadvertently altered its behavior (Xiang Chen).

Thanks!


---------------

Xiang Chen (1):
      ACPI: NFIT: Install Notify() handler before getting NFIT table

---------------

 drivers/acpi/nfit/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

