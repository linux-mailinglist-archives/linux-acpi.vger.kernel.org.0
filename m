Return-Path: <linux-acpi+bounces-18376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A07C2108A
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F40F74EFAE0
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F732E6105;
	Thu, 30 Oct 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/xScyqN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B237A3BC
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839276; cv=none; b=KubTN4Z03oivcfgBIjgyVbycqhOjLJSFyOkAom/6e02HxPe7FI3r2HeEY9pefpX/cZQ4vH9iurNpPFGQ61iJIHgvoWeetIJjsQ9fpQvX0OALPcHS1G5+fg4n5J31s8LiBsYSSlVE7fvbRSOySpz3UMiS5FeIuZlW+pZrlzb276M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839276; c=relaxed/simple;
	bh=W1zw8qCD1fGu6vpnn4V64xxQGTS5z7t2Go4O+Abr6i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+gHoe57X2WEhkLJRwum9Ti4pMfHpRyCQPIiHmsd5LBZ+eFBdGXjW9/Fv0E+mSsunUeSSN5ifFMinlCIfQhkgKgyg8F0llRtugT1JV8Zvetj2pqQZoDgmG/i7PjkACdXvFlfTpFwqNc9ZqKYysCrLED4AQ1LAQJ2gEpdRw4SURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/xScyqN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4298b49f103so509943f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839273; x=1762444073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+2vUN9vUrrG0TjG/UGpxBf0iBedJfrxlMW3xSp+vBQ=;
        b=T/xScyqNpG0vSitb/PRRo3WYI1mUJ20pIOBwISfby+JNFHMvYBLxwwhqPQ1GskxV/6
         sx483naw3H2w9hzpgB5PwhiaqptpL9qnucmIZsFJqhsf36X4n8vQTMIkbNu9S3r0C96d
         xHzNYf0ENAM0s0ZWm2bwpg+iD2yAKWvEJIPA2+iWKSH7HFSx3vPrO0E4pIhI0M+afNkt
         2JEQlLIh3o3HaTkJTD4Gg8H/KwPOtH9sbdqwMhrS2Sw64k+9ICOwVhL3DWRSYLwD3apI
         +2dhoEUu/ykbCSjSgWLja3BYJUwzaS3asFYKL81nELrmNS51jGc5oqUERTG4ycTu54Ap
         HueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839273; x=1762444073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+2vUN9vUrrG0TjG/UGpxBf0iBedJfrxlMW3xSp+vBQ=;
        b=kuft/ClC8nIEU1WjgG8TdHc5nDYRa5Xc+ELTYq9MAjqfYtgZGzohHZ8Nq9WJyPjIT1
         KNYZ/qztKmty6SohKe80sYuir1sITb9efNn8HGgCx70BxZtwNaD7bB5B2Fp+ikscWYg5
         huwp8tWO03KRq2GxYFw1puJjK7CppgOMHgVk1Wp26ApEEcg1GKj3314c9wzkcKv9lMqM
         W+NwR53yOY2CLQSbjUZtwsLoy7q41ZZqhV1D8dfSRLKC9EhjfhLtkt7zqIyi3T+y6R+2
         642NoljCMv1vzIzBT3Npt21km6HgKbNAHJm75LKpKBzYqe6L6NYqrpPSuyS/A7zg/wOR
         qlGw==
X-Forwarded-Encrypted: i=1; AJvYcCUMcSPvbgMB4DsxUubzkdrRaCYbyJ/T59h69mMLevwMMSgZbJ8mFmzP/2q5FCPN4X6MUA88Sp60co7C@vger.kernel.org
X-Gm-Message-State: AOJu0YyCN8NKYrfhqe1lYATfwPaEZJtqHqiHhQx2FZBnDeP/zSQlj4Cs
	5JRmJUj6brHbWugHR7lcEwRYeBZ+T0HjN1qHhQNEArmGDhosWgqI643VY7hK5Oepvy8=
X-Gm-Gg: ASbGncuyZTgbH1OhG+PUte0VhZYg1ve8BuoScevRbTipC2RPECCcCHSVd58nSl1MTVR
	BJkIyc2+duCvXUcvXouD8D7MR7trdPSIXMGR7EOnlpwAUQOQuK993jJa2kTPWl+1YWMkeQljyCa
	zTwFpkSM5mxgQOUoc2oeJ9o3slBiFUufC80B84QZ9I14lZLOOF9BRq6/xYzQE6fbIT7lSK0K4MM
	pTdXGPgIvvuFgQModeHmXCsO8gKTkzGA6/bgUNHSp3jJGXx0V5tR4I3jcQceJVeK57KDmhf5Zto
	4L7+pSBrUlf8HpLOaLZk/SXQRDQtiAa9vm488tWlPRHyz+10AsDpFJXcHMnWS17IG0/HQkipWzx
	6oVGmrBOXUQPrZSOdeGvt6aK4pcoYf1YpzH0kc5ZviB/h1xqBUB651ToGiZSl7GQxgYl8HZBN6j
	W1HX4GadpDYrWvUIo=
X-Google-Smtp-Source: AGHT+IGP0z4V00XKiXMmYp4l2/BZ8F0n9XtVTSemRHjCzKtJaTEABQJsm3CuVaPc7Far4bXVn0wIIA==
X-Received: by 2002:a5d:64e4:0:b0:429:66bf:1475 with SMTP id ffacd0b85a97d-429bd67242fmr59867f8f.3.1761839273055;
        Thu, 30 Oct 2025 08:47:53 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:52 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 0/5] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Thu, 30 Oct 2025 16:47:34 +0100
Message-ID: <20251030154739.262582-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

	system_wq is a per-CPU workqueue, but his name is not clear.
	system_unbound_wq is to be used when locality is not required.

	Because of that, system_wq has been replaced with system_percpu_wq, and
	system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3-4-5] WQ_PERCPU added to alloc_workqueue()

	This change adds a new WQ_PERCPU flag to explicitly request
	alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

Marco Crivellari (5):
  ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
  ACPI: OSL: replace use of system_wq with system_percpu_wq
  ACPI: EC: WQ_PERCPU added to alloc_workqueue users
  ACPI: OSL: WQ_PERCPU added to alloc_workqueue users
  ACPI: thermal: WQ_PERCPU added to alloc_workqueue users

 drivers/acpi/ec.c      | 3 ++-
 drivers/acpi/osl.c     | 6 +++---
 drivers/acpi/scan.c    | 2 +-
 drivers/acpi/thermal.c | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.51.0


