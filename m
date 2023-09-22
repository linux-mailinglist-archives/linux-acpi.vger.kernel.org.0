Return-Path: <linux-acpi+bounces-57-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE87AB934
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 627A5282518
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955C1EA74
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 18:34:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95443A8B
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 18:23:56 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFCCA;
	Fri, 22 Sep 2023 11:23:53 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ae0df6494bso307649b6e.1;
        Fri, 22 Sep 2023 11:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407033; x=1696011833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHAukQqrkJE28GYt3F1ijfvM9aeABkfEb++TlB6e2cY=;
        b=CQbD4ZChPU3/QmT+2e3AEogZEfj3zNrD9zqxDI7j7lwwUSlPk5e/Yz0gPhR1ir7fFn
         QEoqM5sX00kwjUIKb4R5R4OmzakJD4fspojyF6+RFUz+ezSw9cAu1EbPX3sltfMljVjd
         19AgFTtw97i0Ud+2FPcs129DCVXS6G3t1drIcai1ZSh0tWHeyv12NRRpFyeYd49t4reZ
         zYUYB5yVLkJNOLOVrEU0Xn86tN6kChff9s9u7MXszBW9nMPuNJAWuH8qmsMASltTtm2x
         X81/f0n//Qfr7hPKVzt7LRyep+x+1B1EZ0A6oAxjfyTSPA7OdfQ36welBjpw4Nty2NQl
         z8iw==
X-Gm-Message-State: AOJu0YzIG8wk1HAV0rL5GREUzHi4gBfOtaJ6+bqB8erNa8u9dqQwscD6
	Ms3scGCYltZJmQtK6LLGDGnidqeHHqrvOtweNDk=
X-Google-Smtp-Source: AGHT+IE+AqVGPYHSWXqTASuIqrF0RoJU4ySF+R22mQnVc7GUbrnB8Ibnws3GLAfOVIbDo5enOPMz2fnmy3e4Bo64p5c=
X-Received: by 2002:a05:6808:14d4:b0:3ad:f535:7e9a with SMTP id
 f20-20020a05680814d400b003adf5357e9amr528964oiw.5.1695407033053; Fri, 22 Sep
 2023 11:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Sep 2023 20:23:42 +0200
Message-ID: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.6-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc3

with top-most commit a1001c37f83b30a75c17796b453769773b71f9b2

 Merge branch 'acpi-processor'

on top of commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70

 Linux 6.6-rc2

to receive ACPI fixes for 6.6-rc3.

These fix a general ACPI processor driver regression and an ia64 build
issue, both introduced recently.

Specifics:

 - Fix recently introduced uninitialized memory access issue in the ACPI
   processor driver (Michal Wilczynski).

 - Fix ia64 build inadvertently broken by recent ACPI processor driver
   changes, which is prudent to do for 6.6 even though ia64 support is
   slated for removal in 6.7 (Ard Biesheuvel).

Thanks!


---------------

Ard Biesheuvel (1):
      acpi: Provide ia64 dummy implementation of acpi_proc_quirk_mwait_check()

Michal Wilczynski (1):
      ACPI: processor: Fix uninitialized access of buf in acpi_set_pdc_bits()

---------------

 arch/ia64/kernel/acpi.c      | 4 ++++
 drivers/acpi/processor_pdc.c | 1 +
 2 files changed, 5 insertions(+)

