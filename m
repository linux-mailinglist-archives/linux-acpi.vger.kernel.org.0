Return-Path: <linux-acpi+bounces-7855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC495FFE2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 05:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4912F1F22C71
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C821BDDF;
	Tue, 27 Aug 2024 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPOgMgtb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC417D2;
	Tue, 27 Aug 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729806; cv=none; b=K+i8U6t5ltQ8lT2zSQtDZjgggvtE89QG1pRHy9ml0EtCjAB806bZqn+aJ6mxVitK3ISmWPN6R1u6W7CtI/2LEUm/IyUrwbEGIQX7N9NF6j0Kix7UbK/uc99typJI/vb9arkT/HkS9KYF+cHuGGsEBULJ7vKtPDb8/YWoxawBje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729806; c=relaxed/simple;
	bh=Ho1s9vK6WS5ven3f+MOaOZfoDticBN/hl5aZNrTSOik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7IGzjpvIuB4DFpcLIZGuEskmH7QoJaJvTeBJbz8wSq0hOKAcZr0hqA4GvKfDwYI7ikwiHvMxdv92h8PlnylLYgMpVv5+nMoRveeGoM9K+UpWovfNWhjhOZ9qzSReF1wBbgA6RzS5bOK+WwfS9Ydbc8ZLFkwQh2oYRWhScJECGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPOgMgtb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d4161c398so20876785ab.3;
        Mon, 26 Aug 2024 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724729804; x=1725334604; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn0NLpEW1bw02AkAxFS5IlEL/ge7VBPrGJvvCAfuQds=;
        b=dPOgMgtb93g6xfblisNBcOol8Bq6mC6tBlKVgP81CIV4JRKrb4IC+6lDdOk6hw51B3
         cV/4L8qkUXUVsr9L1YXa3m4J5TbjKlIbJclq0qvb7qrQZeVMeEneJs21wp3LskuxaqDA
         b5FowLmU4o/iCHuVLuwUE3v4tIa+DjPNkkv4qGxltwAk5O4en6Yt4SNAXvIxGnoARR5g
         CpNQkP64lsOPMVWPMmMLOKABHMcypqZCDnJO90Q3F/6OiP0I8YXFsypc/g6t5EMiBNru
         VHHbVu/IeVx3NUhasbk2H3yRdKurZ45xvIfqcNO6ZGjIHVIhfcxAdU6HQDTChZX9HwMD
         vqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729804; x=1725334604;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vn0NLpEW1bw02AkAxFS5IlEL/ge7VBPrGJvvCAfuQds=;
        b=cVHHgaQcfXuW/UqdxEqr3rFMuiSUGfeqU0J63qIOv0BEvSMrIk+o0UchGrHOcEVoHt
         aG1uD30vHn30YLJ/yboTBgp/R1IrBY+GC1DRSJNVw+YdN1i2w8JUtOC48P77Zq3vf+1/
         8B49dinXVmqbz/4sDEjcllzLZAjsvt1wE+Nc3V17Lq3dnWJimpYfdEdL5K3/dfVrrSxQ
         wdKp8AYfxrGjskdLoyjbphX7ocx8BePGdVXL/iYs3ZXUkECShYKkZHJTOHiy1xhMrHxw
         v1s3PxUW6AqG1QDStSBJ5H3NQF/GRP5Fgfelg71OnF14orQccrStogFb/kqykRtNDp94
         agFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9w2T9g0GZo/en0D2hAR0bYo8YjMJne8PFcOIJ5D4x9YpTgl3QMLChCFXv8VKbuOZbmKyxfI5hsk0=@vger.kernel.org, AJvYcCXaZNjURMq8q84R4rtizLNh4lCuu+me3hxEQVMAgnnBXVbVK8JgNmjvtBYCQbUHyeoJrVngnf5TfbD+q3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPvGdSVSgGroIcVSyftCKX+PSmUpBXLsZ/Mx4aw/Nn28fHJVk
	gYqur66y/Vl23wsVuxMeAb6kcr7zIvL66UYmAfNS0rp092akCWTi
X-Google-Smtp-Source: AGHT+IF0TZOLF1C0ImuoTX6dAmT09pp9NxxO4tGq4K0QSXsUlhCDWz+2GZxDBkSU5ZjTpy6nzB7g0Q==
X-Received: by 2002:a92:c261:0:b0:39a:ea4c:8c26 with SMTP id e9e14a558f8ab-39e63dd8ee2mr19389265ab.1.1724729803867;
        Mon, 26 Aug 2024 20:36:43 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e7c20csm37054335ab.40.2024.08.26.20.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:36:43 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Todd Brandt <todd.e.brandt@intel.com>
Subject: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
Date: Mon, 26 Aug 2024 23:35:18 -0400
Message-ID: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Optimize acpi_os_sleep(ms) using usleep_range(floor, ceiling).
The floor of the range is the exact requested ms,
with an additional 1ms of slack for sleeps above 20ms.

This reduces  the kernel resume time of the Dell 9300
to 1,124 ms from 2,471 ms.

The ACPI AML Sleep(ms) method calls acpi_os_sleep(ms),
which has invoked msleep(ms) since 2013.

But msleep(ms) is based on jiffies, and the rounding-up
logic to convert to jiffies on a HZ=250 system causes
msleep(5) to bloat to a minimum of a 12ms delay.
msleep(5) typically takes over 15ms!

As a result, AML delay loops with small Sleep() inside
magnify the entire loop.  A particularly painful example
is ACPI support for powering-on ICL and TGL
thunderbolt/pcie_ports during system resume.

Regarding jiffy-based msleep() being inexpensive
and hrtimer-based usleep_range() being expensive.
ACPI AML timer invocations are rare, and so it
is unlikely the hrtimer cost will be noticible,
or even measurable.  At the same time, the msleep()
timer duration bloat is significant enough to
be noticed by end users.

Regarding usleep_range() timer coalescing.
It virtually never works during ACPI flows, which
commonly run when there are few coalescing
opportunities. As a result, the timers almost
always expire at the maximum end of their specified range.

It was tempting to use usleep_range(us, us)
for all values of us.  But 1 ms is added to the
range for timers over 20ms on the reasoning that
the AML Sleep interface has a granularity of 1ms,
most costly loops use duration under 20ms inside,
and singular long sleeps are unlitly to notice an
additiona 1ms, so why not allow some coalescing...

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
---
 drivers/acpi/osl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 70af3fbbebe5..c4c76f86cd7a 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -607,7 +607,13 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
 
 void acpi_os_sleep(u64 ms)
 {
-	msleep(ms);
+	u64 us = ms * 1000;
+
+	if (us <= 20000)
+		usleep_range(us, us);
+	else
+		usleep_range(us, us + 1000);
+
 }
 
 void acpi_os_stall(u32 us)
-- 
2.43.0


