Return-Path: <linux-acpi+bounces-294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9557B3A13
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 20:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4B0E22832D3
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 18:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE841E3D
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 18:31:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A141745
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 17:11:27 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B80193;
	Fri, 29 Sep 2023 10:11:26 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dd26c41fc8so1086923fac.1;
        Fri, 29 Sep 2023 10:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007485; x=1696612285;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT0IvEjW9pOB399mZwHIpi03N7NApqiSsP0JLvXfp2c=;
        b=BXPEf2Zsmyy5pJGEanpGF15+kjhzwsV7uYaxAIxs4qIINfKKzkLaY/YmS7XBP67dEm
         OovgIzuagWT1cnWbD5MEr+zo707vtzT0h1gXZCateXIxPNulVZwLYjoPEYSNCWSgqKMT
         v4QEpvtvEjKqBEEJqnLlGh7ItcYIeBKmuAQP6s2YmSvwDqYncI/wkfIADN5vtNd5JNJe
         De8U0iBRC07U/ym+fB+eSpu4JHSazI2g/P8qxqtM9GxF3xvrMrsUd0dUprOA7u6IsoaV
         cmt0bUAsRzj7KYNNBHt+NuL+fk1XaaYb60C9bSLa4LkMH3UP0AjGiSVM/XHHITa1D4gU
         S1Zg==
X-Gm-Message-State: AOJu0YzitSAQG/TanK/oqYYyEjiCo1E+W50dzDrOyUoLxhywKyE6CMNK
	hAeGN6/kbzvqRI2e0NZhiE2qH4I6V0amR89g6xoaJS3ZtGM=
X-Google-Smtp-Source: AGHT+IEW71uZHJyeRs33phgUykqwnwV3HVNs4Uo2etn84cIBDMEPdPFcmk4i3QHlIOG5G3XXm1FOJYPSxqa7fGayA7I=
X-Received: by 2002:a05:6820:3c1:b0:57c:6e35:251e with SMTP id
 s1-20020a05682003c100b0057c6e35251emr4696907ooj.1.1696007485569; Fri, 29 Sep
 2023 10:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Sep 2023 19:11:13 +0200
Message-ID: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.6-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc4

with top-most commit f4dcf06bc6e0161920b700ba3966411d716a321b

 ACPI: video: Fix NULL pointer dereference in acpi_video_bus_add()

on top of commit 6465e260f48790807eef06b583b38ca9789b6072

 Linux 6.6-rc3

to receive an ACPI fix for 6.6-rc4.

This fixes a possible NULL pointer dereference in the error path of
acpi_video_bus_add() resulting from recent changes (Dinghao Liu).

Thanks!


---------------

Dinghao Liu (1):
      ACPI: video: Fix NULL pointer dereference in acpi_video_bus_add()

---------------

 drivers/acpi/acpi_video.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

