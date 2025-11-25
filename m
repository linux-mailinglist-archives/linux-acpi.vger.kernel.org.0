Return-Path: <linux-acpi+bounces-19242-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0B7C8424E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E00C4E7FD8
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555902D8390;
	Tue, 25 Nov 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="A9CQTr4R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597682BEC3A;
	Tue, 25 Nov 2025 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061684; cv=none; b=gqP+HtEXkhEVGf9YTE1N7QJsJCh9uWW6PKlsWtZgDPV3wOIjKxy8JsXncWUNVRYSaRWgOATEIDZLKw1nxl3dspIheY8YwtwOj6YF4HoTfAGauUHZYdz/qTrh/Wuk8RbC/PBcJQ0XQRHCAF+cQsLqEntzTnDBjnJCZxubxOITn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061684; c=relaxed/simple;
	bh=9vOFtqIWzazMdCPHxFRVurGLYvckDHb3NZHZdeLZqqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxW2+YKSMH8vbvZdkMYmlWC/Rd46MPYLeJEDXE8yxaFVMrmE57w1umisWfi3BcLfRyY7s3T+TQ0jSBQ8ExcS5eDr8xFGQTYceM2rR8kbuEnl32RUJyZbQTXl+ivcN7Kns1bHS/7MGSV1DR2y6GAlY1k6H0/qyXMDbDmXs6PqQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=A9CQTr4R; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 97DD22021A;
	Tue, 25 Nov 2025 09:01:19 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 8640C2022F;
	Tue, 25 Nov 2025 09:01:10 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 5F5413E859;
	Tue, 25 Nov 2025 09:01:03 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 0CD8E40135;
	Tue, 25 Nov 2025 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1764061257; bh=9vOFtqIWzazMdCPHxFRVurGLYvckDHb3NZHZdeLZqqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9CQTr4RQKvaddo6OBu9PNAQdnFH7IEzl/BdXdBL4AsiYh5Cbuc5cEh9UWjOWWU75
	 XZT5iA6L/bEAuAJlts3sNjH1cjfm1ZcV23i/AuExWh5yjs+SfuSUdw6Jk6CxnLeC3u
	 Fq7DSvvYsChknsaeABuvkamilUbs5cKcw/R8SYFs=
Received: from avenger-XINGYAO-Series (unknown [39.144.78.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0CBBA436FA;
	Tue, 25 Nov 2025 09:00:43 +0000 (UTC)
From: WangYuli <wangyuli@aosc.io>
To: cryolitia.pukngae@linux.dev
Cc: acpica-devel@lists.linux.dev,
	cryolitia@deepin.org,
	guanwentao@uniontech.com,
	jeffbai@aosc.io,
	kexybiscuit@aosc.io,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	rafael@kernel.org,
	robert.moore@intel.com,
	zhanjun@uniontech.com,
	WangYuli <wangyl5933@chinaunicom.cn>
Subject: Re: [PATCH] ACPICA: Avoid walking the Namespace if StartNode is NULL
Date: Tue, 25 Nov 2025 17:00:26 +0800
Message-ID: <20251125090026.373878-1-wangyuli@aosc.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
References: <20251125-acpica-v1-1-99e63b1b25f8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0CD8E40135
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[chinaunicom.cn:query timed out];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[wangyl5933.chinaunicom.cn:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[wangyl5933.chinaunicom.cn:query timed out];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Great!

Reviewed-by: WangYuli <wangyl5933@chinaunicom.cn>

Thanks,
---
WangYuli

