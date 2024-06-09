Return-Path: <linux-acpi+bounces-6284-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD690183A
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 23:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3572F1F2122B
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Jun 2024 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C7C44C76;
	Sun,  9 Jun 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Liic4alC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4014265;
	Sun,  9 Jun 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717967359; cv=none; b=BWvvmXztFW/t1IjjeOjJF3JWCtKqL8A+6lvy0Cf+XZtZZ02vqx1BGfgZzOeRhIn54cy/Gapq3dOA8BfZHgSUb5wv3ADSj+u7shNo6Y9cieN45FO8NsiDZ+brKIyYeYDMfDkSqudvpSohSM6diNWSnRwRiotdXrrdQnrqA/lTgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717967359; c=relaxed/simple;
	bh=/E1wD/ufLPJhzP//qxEYP8D8mnf0t+I6DWJYveHX944=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j5QsFitCt34omxbgP/tV5hOnng6jI+FLyHt0DSJx/PeNxBZpcfAluMTyWcDI1BmU0FwxkLqwmv7q3vyQuCNvofIgLhzMRjOcaUDRGFYqteFzfWIMygKPH4gawb18zPEglUdQIL5bv2vJqPu2gHYgUIXA5DQq1zLDOZwt82vMg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Liic4alC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717967351; x=1718572151; i=w_armin@gmx.de;
	bh=9SIub8og3/9ldon22F2Wdln9k3m6OqGkRm+nPBuWpm8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Liic4alCoVq2cf/AWoqLhRhxYzSpLu1o3rNB6coKYSCSGIhXBOfHMd+bSSRpq/MS
	 2wJBdZx+KXFSkwUDGMCnVhnkrhrTnL6tocZoY0120E2CW8Pnx52Go8al975MKm1I2
	 v+sI2gJnYzdapyCGbqhvr4yuS0FaUrjna40LiGg6Fzj3uR2FjmmH+KShUyRwYz9aB
	 82kLDWuQiuFfcVNj975mMi+q27SqxsK1eI6rdJhmzg5NbQ2y4CPnLSenHK9kf1ZnM
	 T+N6tnliMWsWqH6kgGGf3av2O/vOp1j0z1PCi/aZ7zfwpdqrs4VHRxeRr/nEl6XPa
	 OgNVtQFb3IftwTmQmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1wlv-1sRv3P3ONF-00wHn8; Sun, 09 Jun 2024 23:09:10 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: acpi_pad: Still evaluate _OST when _PUR evaluation fails
Date: Sun,  9 Jun 2024 23:09:08 +0200
Message-Id: <20240609210908.4470-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMfD5zp++gZ8k6LdDg44V7LGkBQ5tsQKGQF2fyucr13WNqcy9Gy
 OC/KYQSz3VuQa8TaD7MGKjqxIgxh9Z8OB55mymOiMPutaZFNs44PlBEQghdv1LqCJ0B+5+T
 K/vRRIv6SyvYLZzm4vJKuRaiLPM8zWIxmIFwDP4PQU9GqrYxD+Eh378Es3vvdzJTBeqMXnI
 PIefLQ58DnfqeECawck6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Wr9t1P7ckI=;NM4vT9gB8wBaHD0Z2EdjLhRLG0H
 84tqMLX9FAWEOtSY8WzKKfvzXh3wNfipzdsQ4bknWj+zJxLhxO7MpeK+6gKOcrz2uHWV4a0h3
 RwdNEd+3n0wPL+bRHTol4JfqfGvxkL4c7kCUJA+PojOpRs3A7hjreEY9vUixU6qGn2nkZVdjU
 d1WydVH3jQcr9gabYMCWr4rsCCED40ruxqW8Nap7ujF+O5tjZkB2kK7MbEHBaTsl+3H0G+6Jo
 NFTUKBumjzQ+gZcbtZCupRmH+dFzXiCkJCDQBEfQvgXH5grF5Z9geOP+CM2qVQiwqWhBs49LR
 ZJnnfeUncfuwPkVxblfLZ+uJ9/EEFBAi9AlQ2GxPi68fISajJEkzdZUDNoGBwmuoHRyd9BLCL
 DT2PIl1QUEqnO5i2eHp14n6vs5c9s9gsOlyEt7Yh72mAWl2yrBMUCEMq2nGCdg1JOAezxG0Ug
 lJ+Zz8/7jhm3WouSj9njUS1Twj6gqYg7JttA/jBol14N29LVo13yTqSdv+UfU/v4Nx4bEVED8
 d6TuURXpTO54PoUTHc0pCndKV4qFZ1SwLHuFhWlbVc0gc+gqb/AmBxZcSD89J7d9cA32ynMxA
 8N2UUp1WLJQH2ebpmDeZPmfuoANzIs1OUGh0zmaLpFzY+FP6hOLwOTFfHOUrdW8a7w+lN10b1
 1HuzlDev/XMIN+MWCUzfoUYrrgjxQ2GJS3N1GFrrmkz5ooOWOWjMaYMaCojOHB9UAn7FSMJUN
 7fmUDAeWfGD2/RdIEVpESMW6fvGvS8/wS/b4tWSw+/5Zgz3G0NjAcpxScYb0OY9FASV4m972k
 sBUSWtUEJQlosZvrPfUIHmIXCJ/WotxJ3gXoVdJgxlpUA=

The ACPI specification says that if no action was performed when
processing the _PUR object, _OST should still be evaluated, albeit
with a different status code.

Evaluate _OST even when evaluating _PUR fails, to signal the firmware
that no action was performed.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/acpi_pad.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f0290..350d3a892889 100644
=2D-- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -25,6 +25,10 @@
 #define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
+
+#define ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS	0
+#define ACPI_PROCESSOR_AGGREGATOR_STATUS_NO_ACTION	1
+
 static DEFINE_MUTEX(isolated_cpus_lock);
 static DEFINE_MUTEX(round_robin_lock);

@@ -382,16 +386,23 @@ static void acpi_pad_handle_notify(acpi_handle handl=
e)
 		.length =3D 4,
 		.pointer =3D (void *)&idle_cpus,
 	};
+	u32 status;

 	mutex_lock(&isolated_cpus_lock);
 	num_cpus =3D acpi_pad_pur(handle);
 	if (num_cpus < 0) {
-		mutex_unlock(&isolated_cpus_lock);
-		return;
+		/* The ACPI specification says that if no action was performed when
+		 * processing the _PUR object, _OST should still be evaluated, albeit
+		 * with a different status code.
+		 */
+		status =3D ACPI_PROCESSOR_AGGREGATOR_STATUS_NO_ACTION;
+	} else {
+		status =3D ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS;
+		acpi_pad_idle_cpus(num_cpus);
 	}
-	acpi_pad_idle_cpus(num_cpus);
+
 	idle_cpus =3D acpi_pad_idle_cpus_num();
-	acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, 0, &param);
+	acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, status, &par=
am);
 	mutex_unlock(&isolated_cpus_lock);
 }

=2D-
2.39.2


