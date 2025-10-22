Return-Path: <linux-acpi+bounces-18087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B52BFC3F0
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E6962385C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93493347BA9;
	Wed, 22 Oct 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHmhuRRZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819430ACE3;
	Wed, 22 Oct 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140239; cv=none; b=VhjEGwFanMFfBfbA+waf6Wm6yWw4jmG8icdos8yoSLT72AUNI03AIFx5QgIg538hjgtVu46GL0oNfCUOHhW9/buXdZcCvHMVto8HHFpxOS3kmkL/DpRXhAE7He786ahUnc15ZrIQh0Ok/j641AZQIAbYLfbz1frwJjHuG/hJYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140239; c=relaxed/simple;
	bh=PLp7XbujOGXAFTXiK9QkScRDq3W8qb8d4NGo4BBiEzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDYZ0LcnpZt/0xNc884rVpwG/5n/TqNROj+xDRpO4EAL15R7wMaQVTxmy7Dw3m9bQoOKESBypoBAr+42CET2w/iihmPt6KnmLaBpZHLxk17IgHhBakjF37Uu+ZPPLJ2Yvn2h1kRy5hKikLBsYEAoMgUtAKKBZr2Je9W8EemlGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHmhuRRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372ECC4CEE7;
	Wed, 22 Oct 2025 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761140238;
	bh=PLp7XbujOGXAFTXiK9QkScRDq3W8qb8d4NGo4BBiEzg=;
	h=From:To:Cc:Subject:Date:From;
	b=oHmhuRRZpXGq/7Hy6Kc39tEyDRtOt1LsJjAnZnHnHEXQqaFyHeKOwRRkqHHA5X/q6
	 gfdsiU1T/9MbfSpqMSudarwGSbUikKfICbRdQQr3ka7YkdPcKlC9YrzC0hQoHIgA83
	 eopqLtPFIt6NdYiOe0zNhX+h6f6cY3mLSepMQk3xVYScy+19Zbe3cwZXr/KKPPBsXR
	 Vfs+8HrEMNSYPhVHxNyu3GqlBSmn24PPTvrHb1efmhBgC6oIEGhdcGscCs12Lp3Q53
	 Icak82HQCND2a6YZN+UOgtmIaBm2XtVV1ydiNiXD/GbknCSX8bdwQJJtgYlsxS4Qs0
	 JB66ddMNtpdPA==
From: Hans de Goede <hansg@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [REGRESSION FIX resend 0/1] gpiolib: acpi: Make set debounce errors non fatal
Date: Wed, 22 Oct 2025 15:37:14 +0200
Message-ID: <20251022133715.331241-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

AFAICT we are all in agreement to move forward with this regression
fix (1) as is. Yet I'm still not seeing this in Torvald's master branch
a month after submitting this fix.

Can we please get this *regression fix* merged ASAP?

Regards,

Hans


1) https://lore.kernel.org/linux-gpio/20250920201200.20611-1-hansg@kernel.org/


Hans de Goede (1):
  gpiolib: acpi: Make set debounce errors non fatal

 drivers/gpio/gpiolib-acpi-core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.51.0

