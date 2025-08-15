Return-Path: <linux-acpi+bounces-15731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69A9B28049
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 15:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8CC17E11B
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E43019BB;
	Fri, 15 Aug 2025 13:01:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CB29A9CD;
	Fri, 15 Aug 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262918; cv=none; b=uJaqCRwOobWNfEjfwN6FfCEDsPadxcedkoa8GUNm0rWsmOiWs0LQgJjddL64Fj+ycJ8uCwKaFfTYABn9EuQQOwntBl/vaXQEZ1nwMBXWWIRnlE1nSnn5qSB933OvFLYyMOpT6uPGzb0/HtYmyT1hlAcPwXgqmEOtFdoir1ooWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262918; c=relaxed/simple;
	bh=Bgm3l0Ii+pdLDcq8PslxRwDPo/0S3hZF9AREVvp4txM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nyWDBRqNdOzTbnWEwy4clANuafHHk8pOReDY0eRs09tWOT0p9yqTN4fmXI9ZXctNY3sxP9RuITUqL/dd158POWZb2YJoC2D0IuxlK8zMwIt3KWHbot5GGudLG3ilViUkM39yAaYZl21bnsw3cUq+ukMQYKZ2BhwhqBdRgQ6gyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so260931866b.3;
        Fri, 15 Aug 2025 06:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755262915; x=1755867715;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8G3MB2xb1XINJDky7zAxxmWQS1sB1q+0jgsFdjchDE=;
        b=Y0udhm4exGe5FJ/zJMv+pa3CDCRDJlSNPLR/mPmYo0NqqcH87exWlACVg/gCoCynBF
         VbqkT8iJiNztmAMAKt8SJkXJN3EjG91WM7Jrd9LI+F7zrUrMQu4DeT8zo3vec9FC8MZ1
         XBJijkeAav5wBhJRXfdQwZObYLkOvKlPweWPbhoaZiJ+5x7EQcIr3DCqZlBIJmECrKwt
         z3clID8s92azPt112UKVO9tn7gxpYHsKKKhRDwA2MrO4PMNLShZxCDhjTeVDnFx4o96R
         KW8wE0dvaVgpEyBV6UzdCBZP8+a9yK3yCHrSJzEpOm4X/brTmMoWLhiKuQrDVcasdE/O
         KS5w==
X-Forwarded-Encrypted: i=1; AJvYcCXMPyNwYL7iLVeM2WMjiEvw5C6sUGgNfcSHRi93vtOpyat7B6u5xuy/QwqTyx0BwRIspZtVaCl1mmtDVw==@vger.kernel.org, AJvYcCXXQuMmTxnloRJzGRk4GtF0dIplF5rcZ37qn+ZueIAHgvUcAUfQipWstz5uF4QatFuZR4Qzl2Yq3VSrnDdd@vger.kernel.org, AJvYcCXwDHK/GO40U334qr8d6Cz3k4OzspiEnsgLvWSsl/1Z+V1uuAj4ALkOHdA3tlS1YIPmf46JGjuO@vger.kernel.org
X-Gm-Message-State: AOJu0YytJ0pxP7L3ulxGfpX7cjGNVw0QAJRwPc7na1AbYyATSJCGUkkX
	/tTrkasVd31nfrK6ORXDfEjmTLINm5OW/6fE/yjSpQNyk+b7BXO3ewD3OK6VPA==
X-Gm-Gg: ASbGncu3QraQWKyT9ytSod/8hdxHHI0P+txi0MuUAxMDu/ZLbKCLlvs4x35SptgmWme
	WqkKRs1msxnqgeNWoPGibDOPGTgnudsQ5va8n02dBpVZIvo/LlAHMt9OYkcPD7ZcMWwGj3xii47
	PiOtPOQXfigL6FsmXOKP0rwft09sUVxJGXmvfqQOnBcTmzZ933qGEKFO5KbBJHwVEshf20UQNuj
	bXVG56vGikrwfdboaD1cPzBIR2N/ujLzasRbMSHcSpdJ+qMoyNwV6rfFnUhYswzwrpxXRjOJQx/
	NE71VcxHV1a2otqdTy39ova8pkkKqE+qxH/h/hu/0TiiHRGUH7W2wKOK7TfMl3SweFbh8XH6C/V
	5HnJQWPf/BX489tuEWko6HN2n
X-Google-Smtp-Source: AGHT+IEK0vyQ+opzYgrHi1DhojLvyELLab/hZQjZ0nNY6qUF04KViCKlcgX9AKwmiM2X/iEdJKN1hA==
X-Received: by 2002:a17:907:dac:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-afcdc080f1fmr171396466b.26.1755262914631;
        Fri, 15 Aug 2025 06:01:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618af9d30c2sm1490564a12.10.2025.08.15.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:01:54 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:01:51 -0700
From: Breno Leitao <leitao@debian.org>
To: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: usamaarif642@gmail.com, gpiccoli@igalia.com, kerneljasonxing@gmail.com, 
	osandov@osandov.com, konrad.wilk@oracle.com, pgonda@google.com, graf@amazon.com, 
	xueshuai@linux.alibaba.com, mimi0213kimo@gmail.com
Subject: [ANNOUNCEMENT] LPC 2025: System Monitoring and Observability
 Microconference
Message-ID: <6zbk3jazg7wheklq7t7mexj4ie4tlsgdylzobgofqacb5moxc3@r4d6222hyog6>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

We are pleased to announce the Call for Proposals (CFP) for the System
Monitoring and Observability Microconference at the 2025 Linux Plumbers
Conference (LPC), taking place in Tokyo, Japan, from December 11–13,
2025:

  https://lpc.events/event/19/sessions/239/

This microconference provides a valuable forum for key engineering areas
such as:

   - Kernel Health and Runtime Monitoring
   - Hardware Integration and Error Detection
   - Correlation of Issues (crashes, stalls, bugs)
   - Virtualization Stack Monitoring
   - Memory Management and Analysis
   - Anomaly Detection Algorithms for System Behavior
   - Automated Analysis, Remediation and post mortem analyzes

The purpose of each talk is to share challenges and discuss potential
improvements. Sessions will last 20 to 30 minutes and aim to encourage
brainstorming and open dialogue about ongoing issues rather than
delivering immediate solutions.

The conference acts as both a knowledge-sharing platform and a strategic
venue for guiding the future of kernel technologies to better meet the
demands of large-scale infrastructure.

We invite you to submit your proposals here:
https://lpc.events/event/19/abstracts/

