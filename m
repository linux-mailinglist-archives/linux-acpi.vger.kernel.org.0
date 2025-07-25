Return-Path: <linux-acpi+bounces-15315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D442B11918
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68BF17C872
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jul 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81D2BD023;
	Fri, 25 Jul 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="a/x1jTyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF5BE65
	for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428236; cv=none; b=sedQUWhhvuQhoxb4KDrkQYyeWAXk0J7R6KA52W/XUyEbifRbTlbv7THsw0xgU9+yhaEDtb0HeEXwhihWYUQivQMslJ5r3AIWYFHLadcnV+72FZ/n5SRPPY2FBoQxTPacHQSAh/PSbHQLMIGDwailIV2p3xZe6O2NXj0yIz6jKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428236; c=relaxed/simple;
	bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRRpW/+qnOd84z2wbFHlucEAYmcq5IdrpzqZ6kWXrkKPeY6H+oqVO6o7XjYR+rFgtkfGx+mW24Ku4giPIy0+HWQnumNyxOnv4vChXB7jdQjNkUVRtsRW+ND5fmlS16wnrcRMJs0GyR7kQWlo032ZHdLtqkFdd9ZlHZcmHhx34i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=a/x1jTyK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so1787488a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jul 2025 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1753428234; x=1754033034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
        b=a/x1jTyK/qKTitJcYkrWORBcR3ydBBIuk9npKyqEcV5Q77voed4cQrGDmFUUd64rri
         ctl4IW2caIijwYFYGZ+xFmh+YRvgfeLZJcvZrjQJZL32T7BWnnAWR1WLdGR1ZDu1Y4E/
         G22cXQ1uOhPmtthWU6gwLURcNj7/YD7l8y6BkKrhnfhxM/SmmEYN2+dSFNm5KGhxGKE2
         HATzntig1ZX2JQidJZTcUovNAZid26Z9EkuEB4kQ21ZIOlPyMRgk6nJI8aahQI+YUGRM
         H1eBhEuVpJKM4jESk/hbUxON1Nr6Y/BvdTGI5nGmieMPIBZhYa7MuCYKlqzZQESddYv4
         cgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753428234; x=1754033034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf9koozAKRmYj7gL6jetKlbyQ2feWfgoRBGfH5UIHHY=;
        b=h5Wcu1mt2fx8QUkc2Tz/zV2ydOLdWd1sp3CqiwZ3bvzImi+hEtjcmxRjYAHrggLONu
         3CdjmU8SlAEMY9dPVZfW/ZAv+aMVMwo1TEvEvms6nU4zqxqPAybayJSFEvxIG/Zpv8xk
         sUByfmt1UqRVpvU+Q1KjJYuF+MswAdUndGwnrkvTaP4lUcJuGegLm6alvyo+nSdTHO3+
         dfjlPJfe53mzzWWQUiA1MVeOAy2oBMUUxV6EgeiAMjuklAyzmg4PwYhq2wqimdnDilew
         v3eIbiNV79qqj56BpDRedzIl5wgDLooyLofluLHRSYC4tGzVSuohU8RdyDQYzDcxPIQP
         NLGw==
X-Forwarded-Encrypted: i=1; AJvYcCUEMiUlHD2+6pL8edT/MYju3TdJJ0bPpur/KOBEHo1hvpx2pxScpemSRXCMiMDbJ3ZHn/m31nK94twf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq6/GcyGdC1CV+WzMNvz7LzvVsmD8zOrztdrwBV6UWhjCFjIwK
	cWpnzny2z6fltRszXu7SUeNoOXwlWPlxa8ZR5NzEqi17vuVnemsGwYCmO0M7gmwTk7Fz4OaDMZX
	KkBrKVLc=
X-Gm-Gg: ASbGncuy+GvFwyvWRl89+dRYc8OapndGXNMi69oCgNjGcAMF/UNzZnnOplfIdreRwor
	8ZqceHIDjhfXr1Dl8dkfvPCEZ2MzRguQZTlUraBnvcnSF58LoWfHRnFcSpcpamTlJyxRcM8Qn28
	YGhJSCzSpAKPm4QByveaZPmSq7IJLoUBMzTa9M4QA3BS2FLKq/CqoYEO6bw5D6pA+VeRn7lGLWq
	5aLTi0Gd29S0pKYZUE2XV18niCeq7Rpb5sUQLFKkDu6F5rtrSknXzIO+U9Nzj1TwBJE127Y4Y/5
	L6a2dIUci3Ps0K6SfKTayHimE20y7cw8qJKNrsIwHn9qL+tAl+2q0EcLVBBALUNihs8jKQFaQWb
	4x+LesYzoBsnNzDFqm8qCE6D29vGPeewlwqWhGwAtRGmz
X-Google-Smtp-Source: AGHT+IG78dnuQvUMmwTY1TJKn/E7zLAL8E9WAkLrjUIa7PmZipcS23LId/93uoJ0ZMRld5KUadbohw==
X-Received: by 2002:a17:90b:35cb:b0:31c:15d9:8ae with SMTP id 98e67ed59e1d1-31e77a3266dmr1491815a91.33.1753428233845;
        Fri, 25 Jul 2025 00:23:53 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:fd43:1ae:25a:bcd3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e62246f8bsm2119998a91.1.2025.07.25.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:23:53 -0700 (PDT)
From: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
To: rafael@kernel.org
Cc: 409411716@gms.tku.edu.tw,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PM: Use nearest power-manageable ancestor
Date: Fri, 25 Jul 2025 15:23:50 +0800
Message-Id: <20250725072350.43631-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
References: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Is there a specific use case in the field in which this change is needed?
> If there's none, let's not make it.

Thank you for your response.

I am not aware of any specific use case in the field where this change is currently needed.


