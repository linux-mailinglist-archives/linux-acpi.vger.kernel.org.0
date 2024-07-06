Return-Path: <linux-acpi+bounces-6780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22E929196
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CADA1C21524
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 07:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530BD1C69D;
	Sat,  6 Jul 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuOiEqs5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B35695;
	Sat,  6 Jul 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252080; cv=none; b=dn/OQYaZ+SoRV1tNtYuXNxq48aBQ3TyZxS2msRUPGGcNW3rajlAolgzupLUpTr82DtdKk+EPEbsGyA6m/XWVyEvqsCIAoqgn5+NxF58tBrnAv9q/jPacsp7RIsE50d+AUhYF1G0vgXsSPQgMNsRb5O1RnAgmD2f391C8ufkWJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252080; c=relaxed/simple;
	bh=95RLI3b5SBkmmjlgEo5mp6QhKQFaBiM2JZRfxIGyZdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k4jqe5NDfk1FP2NuY1QmbwFAQYMEkVwSAJmHQihNrROzrNAkF7+5IAyTu34/Ja6cPkG8yEysgidxSXccw5g295SbsDg3dF6U1I/oI8sNvIvhdiMcZPX6fmVhDu+yojx89m9ayeTqnqLgu4761W2rLnU1U6oVCOQpLDi0IWx/teg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuOiEqs5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee90f56e02so20460031fa.2;
        Sat, 06 Jul 2024 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720252077; x=1720856877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cttom87E5+4OpXBSV3X8PkPjG3fuWndC+iBXHHW55Fc=;
        b=MuOiEqs5IHwThHTPqB7ctGhVwYrCjGh+Z//JRfAUj2phcTi/QNC5b8iVP7TevjIpI8
         BTZ2EYymroILYyRbkDggW3tbo9zJZMdkc2b32KcwCxrUWRyi2iAXn5Ri8cLjvugxSIvQ
         a2HTyLk1JqZG78a3smkSL4AqitB3P/jSkDBxOAWbbLzyRVh7ed+P3SderTi8AfHbVVaL
         Pn2fbkSlIXVC2ObOhsHKM96/hnY9wtdqHuX+x46J6uQZf+E0/kNE+PQ52cM/U2bDSXtj
         LgzYFbViUY+/QZ0qehKwTb9eoSC4RI2YF7dMt21dTHh7atua/zLUqW0onAj6eDFFf7ZL
         8aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720252077; x=1720856877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cttom87E5+4OpXBSV3X8PkPjG3fuWndC+iBXHHW55Fc=;
        b=pIKeomYRIdUUruqSqjQi0i6YeOXvZduq1Yo8Z4wnd4qeugYTvW4N324/U9OMCAJGJO
         qhX5dhwAKxo8k3P11SftB1QflsMpTQ/jaJck5eBhGwmOCTry91e4bOZWm5G/tsZJ2yKx
         W/KotsohxNmUPuJCU3GPAYbiCYu6Nd6aBsZHd1gJsoYEQwEo4Rd5oWCuXvyE4etAKDg0
         z9mm3RTka73mOka1pmF7GW9iS8xZ78HR1alxrL9jRZz1FBHPScsIPQjmscrFz3mBaqAZ
         L9GWVQPyVD0sis8sbzEC7bqZOT74xCAMHgPTYpMTfvh2BaoPj1SGY+3rmigqt1n0hvwx
         5GBw==
X-Forwarded-Encrypted: i=1; AJvYcCWRt7PK6CP+pmu5DJpz7cSyYXp+52J1MfQPjtX2JP5LT8NHSeMgAOfmAThWwGkdb5px1SUoahp5bVxS/dvwxQLpu2O+tCA/q/nfmQs1E1sA7xfkcePg1BK+YR6Wp+dMLA3IcmJ/4USs1w==
X-Gm-Message-State: AOJu0YyrP4ce6PqtQZDAUDVtGbIgibeuPmBF7l16yqgxwHSx+y3t8fFp
	cCdAR4gIpk0ObyoGWhDZL6GqxnI0AIP63KQhViyS74lVGOm/YqQb
X-Google-Smtp-Source: AGHT+IF9a+U1gHidjYFIpOjUkzsyNk7EKJBId5hC5ii2H1FVUWSn5xDYL9j8Jtrl8oofRviLU69cKw==
X-Received: by 2002:a2e:7e07:0:b0:2ec:500c:b2e0 with SMTP id 38308e7fff4ca-2ee8ed95f2dmr43510951fa.22.1720252076484;
        Sat, 06 Jul 2024 00:47:56 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f2375sm87563965e9.27.2024.07.06.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 00:47:55 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH] Updating a deprecated use of strcpy in ac.c file.
Date: Sat,  6 Jul 2024 12:45:05 +0500
Message-Id: <20240706074505.9885-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy.
strcpy is a deprecated function.
It should be removed from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/ac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 09a87fa222c7..ad1427a384e4 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -213,8 +213,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ac->device = adev;
-	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
+	strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
+	strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
 
-- 
2.34.1


