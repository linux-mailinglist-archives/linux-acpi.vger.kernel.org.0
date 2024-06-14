Return-Path: <linux-acpi+bounces-6426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3728908C70
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5033E288BD5
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806A19AA41;
	Fri, 14 Jun 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYboIbQb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FD146D77;
	Fri, 14 Jun 2024 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371746; cv=none; b=aRcOvr/xXZBkeNLdVL6z3Hia8kukExVklS5MgpQ52VEGVzBmg6W3FlgInI7MaNKOnrE0KGRPmkeEzTDVTRR8SelCP5R6hUe8yJ7hIaS0F0AdsfwVGljA3FUP7sBtnLFKWq97lVlt7SX/FUTco92+aU1/kxtajL25O/zodRiGEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371746; c=relaxed/simple;
	bh=R/dEK7erKuj5WmnEEvNZpMkqO7j2Mv4fvD8O9G4QDGQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s4gUbfSVUuiVtFrwyyjGLRrkjnqtXLJ+v4Xhs2NTwjVQIBgAaZe/WfQZvYAOjSDBWsoBkY15q7lCMQ3KsJszv25FcGqJ6ndUFCVW0xnDUcQp8o2dBMVA4swc88wepuH/LN5xnhIr+5Y2Zyz30WUfiz1z4uXIQxv85kNR/L5Ldrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYboIbQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC4C2BD10;
	Fri, 14 Jun 2024 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718371745;
	bh=R/dEK7erKuj5WmnEEvNZpMkqO7j2Mv4fvD8O9G4QDGQ=;
	h=From:Date:Subject:To:Cc:From;
	b=pYboIbQbG3OBCvt4pItZwDvVRCiww1Ma63fV32uXxj9eTOBrLKIoACCw58M9uFNCE
	 ZlmOnwGCGQEqhaiGYDibYR4rTBj0qOxju3Z/bwlK6+nFeYRNXPyYaAs5oNrGaaW9kW
	 Gte/rRGOfk9Iem8xg9HpjqSAI+nkMUzFd/NbwSVCpeZ1dOpQcmBWJ7gErzH4C+/73c
	 9krUAp21mZldORxfZkN8D9AdCOnnVXdWskBdHisKkqkebaY++HXFQGVaLbGcLmewwO
	 v1EjcK4M0ui9o6mye+sDoWU5tApaOogy5dh1Em8+fWVBM/iFMe0ljtglfLcMpRXUF9
	 O/BJVtXrJoKxg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d21c5b48f5so332710b6e.0;
        Fri, 14 Jun 2024 06:29:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzwCJHj827BiDJMgqYkZBkdJfFUW56IpzqUUdE+/RB9Y7NbTayNY5adTThdxfocjkudfyNY8mTh9EwRsWH3IHCNClb5saG2G6BfUgwSAkXJsxgL3e1Ze6zu8t9JBu86tHhsC41Rw116Q==
X-Gm-Message-State: AOJu0YzHQgKLjCeEtxBKX/UbOTcNwDY2IMcxtKJb6xwuzT6hC+U0RIjd
	uAzHB2Q2cJIS8y8Nbhr4KXC9JM2Tz3vuMRNyKsKp/lqNUR5pAQC8XFN9SqS615/plJtZ6yJQ7LY
	rDnEqHqq+nMTPQ7+otsZhmgsQehc=
X-Google-Smtp-Source: AGHT+IHBjPH1fLvIreM3TOnlRQ5IBdjp127QWWvmP5u6LcMBDVbmVJA8H25Xox6+8GYfUK/LbZdgdkcgNI50Gfm7PnQ=
X-Received: by 2002:a05:6870:e8c3:b0:254:ac99:1151 with SMTP id
 586e51a60fabf-258428f79c4mr2819192fac.2.1718371745087; Fri, 14 Jun 2024
 06:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 15:28:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfkO1E1ymviaiqK92jzG53JKf0mHj6S3tjXCkRuifTTg@mail.gmail.com>
Message-ID: <CAJZ5v0hfkO1E1ymviaiqK92jzG53JKf0mHj6S3tjXCkRuifTTg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.10-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc4

with top-most commit b6846826982b9f2f2ad0e79540521b517469ee92

 thermal: gov_step_wise: Restore passive polling management

on top of commit ae2170d6ea96e652c7fb5689f1980986bf48b7b8

 thermal: trip: Trigger trip down notifications when trips involved in
mitigation become invalid

to receive thermal control fixes for 6.10-rc4.

These fix three issues introduced recently, two related to defects in
ACPI tables supplied by the platform firmware and one cause by a thermal
core change that went too far:

 - Prevent the thermal core from failing the registration of a cooling
   device if its .get_cur_state() reports an incorrect state to start
   with which may happen for fans handled through firmware-supplied AML
   in ACPI tables.

 - Make the ACPI thermal zone driver initialize all trip points with
   temperature of 0 centigrade and below as invalid because such trip
   point temperatures do not make sense on systems with ACPI thermal
   control and they cause performance regressions due to permanent
   thermal mitigations to occur.

 - Restore passive polling management in the Step-Wise thermal governor
   that uses it to ensure that all cooling devices used for thermal
   mitigation will go back to their initial states eventually.

Thanks!


---------------

Rafael J. Wysocki (3):
      thermal: core: Do not fail cdev registration because of invalid
initial state
      thermal: ACPI: Invalidate trip points with temperature of 0 or below
      thermal: gov_step_wise: Restore passive polling management

---------------

 drivers/acpi/thermal.c          |  8 +++++++-
 drivers/thermal/gov_step_wise.c | 17 +++++++++++++++++
 drivers/thermal/thermal_core.c  | 13 +++++++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

