Return-Path: <linux-acpi+bounces-13909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57999AC47BA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 07:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2851892FDA
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 05:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3D1D86F2;
	Tue, 27 May 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dr4z9nrn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AD199FBA
	for <linux-acpi@vger.kernel.org>; Tue, 27 May 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324623; cv=none; b=DMc2NngCajdwJFugVlZuX82F+frgfqSrCUbvw7s0vMNI7kkFveJtbCUbbahc9T0IvUdUXX4zWpn8PxexLuKlxYi1Sx+N1VsDbX8pC+Y6va4lZwRLictmECNLenlFYnIFXE4tmUVHu/V5VcOciMG2e9Gvbo/enaTDbzB/xIymZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324623; c=relaxed/simple;
	bh=OURZMg8Ef8IXmiVjiF4H1Y+g5xJnfN2ZoAXJr2sOcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bqruZBGhHNKl3Y+HH4noLbMVHaaTmqVuWHCEHS/V3kCCsRzdLlLvIlllGERCCWc1JTdicwwXNziU8FRfgRIYpfWViQfjRdNSjLk2fsDtNsZYVUW/V1dgM07snrG+NQ9tbqKiE/zca0rklO7IZJHscmIP1ZIc7am4zdLrHYjSQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dr4z9nrn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so369304a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 26 May 2025 22:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748324620; x=1748929420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLieAIh94J6gkKijZufmzKxSpC/oK+MIvZ8kzKh+soM=;
        b=dr4z9nrnFfW1YHAtSRwrr0JW2yRqbJuhTT1drF3mHpkrNsy5e06zIWP+yK0f9YYOpG
         u4U8Ukjqen3Xfq23ch10KLXaVEeFBE9haJ08NxswCqIAz8CchlFozxFAmKEr527ZGTfk
         OJBoZe4o8v2URYsAhSqwoSogsGNWu3QoNyx59vIuJmwzwXB88s+HhaDSX4VpopnngLO3
         31dB27sdU0jsmG6q5m7nOb3gmzKgZispgZtMNk98sbKVEyzRjgwodGi/Q7My/PRu899b
         wEH0p3W1qrKnv1id4XxNMBxDV+qWuNjE+HX2X51Hh/hWx8kiG8yuDWNa2xpivuDFZBks
         FJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748324620; x=1748929420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLieAIh94J6gkKijZufmzKxSpC/oK+MIvZ8kzKh+soM=;
        b=PlEJ3W7XFfnqZz7zKlMQhhKfZRfwoYUgtkvTm3sJs5CtpxiZtlpPAQT0/JS+nWw5SK
         I6H57kdGtofNvY6VK1/DskBZdl4rvDIpVNYtPmZJyyEJHa5kmcLfg2ST2Z9ZGpIA2KU7
         DDTMPFZOXdnfOh/rvJNL0gjYBTsO9CAFgfNI5n11EOEcsPoRTLDqY8xr0VX0X7rcuIkU
         jOh+SKxOX4KNJX+CdzZ5G2vexrqqXvlRVlVoXcs50kH/ldmoirPleaNa1Lt9bzfUkX/b
         Xuhv2DlRBTYGHlYguHZ/39os+VvYdrP4hc0qTY00tFFVnhDxh7gVoHkwzTW6TVGzdpXs
         2nUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw6QkH395jAm+Su7QaykHRXm1oHYqH98NpIo3fLhv5fHmT00S1YsuVwv5JJT0bVjk3/G4zWIMJbKGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxtRE9oU3dO+HpT3EXiscuF0SCkZpGREvd/0ikURCG8i6YLn/
	2EfbDYQYLFOuO/IDVP9bk9FS3hBpR/QfLz3WDo9bfZL3DPeJ0MkGnJeCIHRDbUrdoBR4+hJThO2
	Tgk3s
X-Gm-Gg: ASbGncvFai28vTalo69hAk97WNZp04OrcBfCsh53u9W3XCEJyV7gsSGwghgmqDiXOr0
	0TgWBw55N7HI+U4FW4tkV/dywEYLFCBulijlfd7+bW3TuuQI+6XC1lUCEj6Kb3tR5zahB0/GCdC
	+SWVsCDDAy1nZe2f9sGbxVJkvkCJF8OuY28rfD3elpo3rbcPzEgjbUP6aZ8t0TOHYMsbEnl1XJ0
	/jWpqcSNtDJ1324wp6FIffg4cgk23sdMIlcGHBIfW52jZlbk0FvfRsfYvuYnEFcx+vjEnt6r9k0
	7hdKrSuxOHKzIqOyE5/jyQB2nmSU8gZFSb4y5unIQ6X6gDgHMW2z1zI=
X-Google-Smtp-Source: AGHT+IFmKrrq1O4ANeu08c17wZM+Eb8aGpytrPGvsys0BX7ope/iR0SZAmtj4dLBdx62Ecb4ClacwA==
X-Received: by 2002:a17:907:608b:b0:ad8:91e4:a92b with SMTP id a640c23a62f3a-ad891e4ab65mr54007466b.30.1748324620384;
        Mon, 26 May 2025 22:43:40 -0700 (PDT)
Received: from localhost ([41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad88523a96bsm142443866b.73.2025.05.26.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:43:39 -0700 (PDT)
Date: Tue, 27 May 2025 08:43:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jon Hunter <jonathanh@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ACPI: APEI: EINJ: Clean up on error in einj_probe()
Message-ID: <aDVRBok33LZhXcId@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call acpi_put_table() before returning the error code.

Fixes: e54b1dc1c4f0 ("ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/acpi/apei/einj-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ca3484dac5c4..fea11a35eea3 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -766,7 +766,7 @@ static int __init einj_probe(struct faux_device *fdev)
 
 	rc = einj_get_available_error_type(&available_error_type);
 	if (rc)
-		return rc;
+		goto err_put_table;
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
-- 
2.47.2


