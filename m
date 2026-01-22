Return-Path: <linux-acpi+bounces-20535-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH8xCqsOcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20535-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:48:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778766386
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0AA084BCD6
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25213E9F6C;
	Thu, 22 Jan 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaGRZTN7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EDF36826A
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080550; cv=none; b=haRUt06qDm1n2JcN+s/PW0Q2LmeYnAbw/NQmbtv8GIsI+tRCZHZJRvtC9nxxN8ufYhYTweW6L18+g6pJaQEteT12rSEOjtLCtkAr7LkzUfJDZw9m75aD39ocx4d+LlkskfXEl90FKJzVBnCPuUAMekUuJePoRj/KnjhvO4F2oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080550; c=relaxed/simple;
	bh=ztYVENt7v2HV0MA+gDJ2YDMe5KsEdk4xcYefQWN+lgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU8VIg/lUgsnqrfPbU78ztF6BtYHANfxzZ4Za5/t8FaN4fnkAwyaNEQZTkjZV8NI0/OQ7Z99RT2DSu0x+2RSGOXtP5bLTaP7/Q3mUSla3xZ2oOnTlWc0zL0EagMK/ZrQXAzCPVhKsQc0AxqnhPqZW4qmk8915BB9L/yJGUsOCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaGRZTN7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a31d7107faso1062155ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769080549; x=1769685349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztYVENt7v2HV0MA+gDJ2YDMe5KsEdk4xcYefQWN+lgg=;
        b=IaGRZTN7/CsSEYN2s0ijtMBkGB4DPqtWzBGZNg7hsGtH6sCpUARa1bp614lJPsbnDZ
         AgtHDm4s5Coaue3w0HR3avvUxlVEne5nx1Po4GQS5Mb69UhOy7F3xZ8QIZilGas45AHh
         hWln2dKPJtaof4CmkCIP8vW8A96+NynoVFEkFB7NRR6zHCudeaQ138JgRurzJu86ibWW
         tohQnLhNwIBtng8lV20H7blHrhoVzLRdsoRHXFGHLjZHDBQAHoge0BE8OfycpdMVmT/d
         S64uRxNWFNcY9hFjsyypaHxV0KEoWUYguuBOSyNj3iPi967bO9ZZDYSGv3p+VqBJwpsR
         Y5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769080549; x=1769685349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztYVENt7v2HV0MA+gDJ2YDMe5KsEdk4xcYefQWN+lgg=;
        b=XvX58KL9kl1CDoofaELIv6/H9Q9w04iqsP2H1nIooDng48JT6Aq1/WjaElYT4X6Bn0
         nVAucnaqP1w+H7Mn2nHAW5KVZ0c7bvs2vTrw6uIIa/jvkWUSMZVWvIhaufAuKb/xvA/N
         tAqo7OUCEcIWmms991ClCUvyUYMw+p3Cu1CSzKguqGbEsMyeFbEYN1xa1fyvcskLgtip
         ApT1fNi/5PGTMJo5ixV4atSTPzvmHuw5dT3/dehNg5u7l0oMx6Kvm+JmgKz5y0YtVcMj
         9WJHHmG+2kqF/hX7QT7mZnuLznBdHC7qcgDcc0/YaCF3QFgOSEoD1FZwvkh4XQ5XYyHJ
         2cqA==
X-Forwarded-Encrypted: i=1; AJvYcCWjTacRlL8mfAoCLmi+9U4/mIsrUjhD5kuNGZWr7f+kATemd2bAL6KBD2gFfJWDKEwx+QsVYhOcDH3/@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1lHIk2q8HwEqaZVXNA6EhZrrWwQf5VBw2gE1JxGBRpeUCsQh
	kzy65NOd19VjLrwhNgBYkBv0G3d2p8z1qItudcsxH9exx1cCrLEUVnMy
X-Gm-Gg: AZuq6aIBuuVe/LZgd2+1V/1LKcjAzbDWf+cTA7jKMd4NRcFCWMqm10LwDZOSU/RG1H0
	tXmbJ/9ieUAL2ym2r3uHKaMYQSkWQVWbEvxrN701UX0B0DneXTAjeo3Qrfrei6LbJYJxun4mTXw
	qqgR2UMCPZq6odDYgby1jKcZ5MttQP3z7XILT6jSk5vCL3gpf5jnjgSYWAYcK5gNH+kr7VQ9o1E
	J6rIv2NHq70JLe4B9z+lW370cqSKJUpjZcvUzg/8T+PC1Id24oxE/4fpY96yzGnJazrX/B2Nn78
	Yvms/RLFxoie2kBdYIf3WH+rxJ1XkjLFDoWn2nmsrlMrEmpiJrn0woOVHSUPZm8t8rFp2Y9VNcn
	Wld3pRvQeSsjh5l6g8LDoPqxFWtPfoM0D+qcmcmCe4rqr1+fjTq7KffPmeqh+QAq2y5d7tlaD/L
	GCQ2x7t4fgfEDDkFWYBB2AmQ9oSys4jXu7qpKwDp/OAaiZInw=
X-Received: by 2002:a17:90b:2e84:b0:343:684c:f8b1 with SMTP id 98e67ed59e1d1-35272eea9c5mr12995326a91.2.1769080548696;
        Thu, 22 Jan 2026 03:15:48 -0800 (PST)
Received: from localhost.localdomain ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf395851sm17379236a12.36.2026.01.22.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 03:15:48 -0800 (PST)
From: Shubhakar Gowda <shubakargowdaps@gmail.com>
X-Google-Original-From: Shubhakar Gowda <Shubhakar_gowda.P_s@dell.com>
To: ira.weiny@intel.com
Cc: dan.j.williams@intel.com,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: NFIT:Advertise DSM function 0xA (Query ARS error inject capabilities)
Date: Thu, 22 Jan 2026 16:46:36 +0530
Message-ID: <20260122111636.51881-1-Shubhakar_gowda.P_s@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
References: <20260119184438.19942-1-Shubhakar_gowda.P_s@dell.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-20535-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[shubakargowdaps@gmail.com,linux-acpi@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9778766386
X-Rspamd-Action: no action

Hi Ira,

Yes, this is a replacement for the earlier submission.

The previous patch incorrectly referenced ACPI 6.5 in the source code
comments, while the commit message stated ACPI 6.6. This version fixes
the inconsistency by updating the code to correctly reference ACPI 6.6
and resubmitting the patch.

Apologies for the confusion caused by the earlier version.

Thanks,
Shubhakar Gowda

