Return-Path: <linux-acpi+bounces-20966-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNsmNe7Kjmm/EwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20966-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152E13351B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A49BE300BC64
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AF277037;
	Fri, 13 Feb 2026 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="WS+JEqd6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FDA272801
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965737; cv=none; b=aChPrv81lVMlFnv6Jp47vN+bX66z8LTZmhkbscwmtlG0NPTZ21TQ132oDW/f+gFnWzN3C5Y3VH22jNpmgCGqSjzXm14o/yMAjqvc15e1obWGycW0NO7nOYWyf7Sza2wljh2F1n48Q9zcseEu0tK2MkBYilQR4ky/esjlBUL31As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965737; c=relaxed/simple;
	bh=AVZCl4GZmpqjSi6R8hLihqG9KSmolznsgfA2qabbatk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8gKLBZXfrWrlbCnp3XvdZMluVbbXrpicazPLTzUs2A1c0WboBgtJuILpohungsBoCRygQKbL3sPvknfyaY1Itg/DpbfnzTv1lCtfgmskC5IY03QWY0ON2f6kz5nFobKyTjPLkDXf2UaN30amViFTCWGEq17sd+Cqi8LIqgGwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=WS+JEqd6; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4638fe85a7eso160610b6e.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 22:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770965735; x=1771570535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVZCl4GZmpqjSi6R8hLihqG9KSmolznsgfA2qabbatk=;
        b=WS+JEqd6Nla0TFp+blKDWajzhd0pnsnr+N42E+Cgf8RGMStl9KgSQhf8Z7I+y9R58l
         aTvMB6jcuyIjHMdAqcmTIzsGcAeaVOWrMiat72Sz8yeorhY3Ortzp/shQwmEj+Bt/2mS
         1SmyPQdxSLomcLwD3U5KqbTG9VPWLzUC52mT+/90mmoVqfINvTE2Uya9wD6pvuyNMVM9
         C6dTx2jvm8WVIO7xzhirOQFj84j+6X8shukGgOaAV7tps6FhppUiZkrdQbAjn4YEkKdC
         gZ0ENuoG5KocRSQ1Fi9yxX4MU6c52G8bi9gBmIO3uVwkYMo7qx0X+6n+7sV1SEAstkEn
         YF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965735; x=1771570535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVZCl4GZmpqjSi6R8hLihqG9KSmolznsgfA2qabbatk=;
        b=Z85e0FrUi1cF9+qd2oCECU2GMSgBj5bVQVFFznUJl30OR4QGGrMEqHrXclqoK7ers6
         fRVVAnB91q6Ap1zPrTRFmLWsxNj1ZAiVv8hTezy9HRJ7k3dJSoxoLNnigAlN7HcieZvU
         HbAa0OGa/5uxALLlFCg2rJOlOG84Lncn0/3pM7ZQTx+Mtl6o5gDdNv4JwF8GZcqqbgVw
         9tH3IntofWUwDxV70Cc8nrV0iq/FHrZx+rcp1VsYYVb/PAJ++a1KzvkPj4/5m1EcTDy+
         3zcBcPO2TbY7pK0724Eln0MujpW8oUBPuVScEpbangfOvbT5j/WbVuPZ45PhSD705TtI
         SD4A==
X-Forwarded-Encrypted: i=1; AJvYcCWhKuQUIuvIDJ85J+1UzwTQOouClxVDwmrbV/zaNuWJ69g6kPxhSInkWHOzlPPuttxWlfnAt6QovRak@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnE8Uml6HjFMcphRDCfwdMN3OWln2nFNm345TEDEu5jBDuiJM
	j+wgu89CFv20W/waFWnM2gQUv0cAkEoLSWbsLeW/wR9ZJMQw5PiFGNsstdbnfS7fkdc=
X-Gm-Gg: AZuq6aJ3Ub14wjJOnXbDjfEcG4vfhNoGr9/ZVxJZF21n1sxWH+3jiqNyw3tAsBZf9d7
	EpCdVfxRAUsJCkwUKhYfWExTr3y8jIA9I6qUAR7tFEpHcoVvH/k3d+nIlZ8ukHAcSEVb/z6vxCq
	UILrjiyP+QjfGM8oZ8b7tcmJSPojrxnPst85Ih5DBwvtZRW4LWDmytQNmgV3LNIFrlyuDWSmA1H
	aiwNQqHQN/q20SJM0oqtJ13+ZZBH5i1q9EKBzAoqwxs29vjLYnJjvRqtwKtve7xKYFxS8uA564O
	940Hjz67BTpPsK6o1S6MpTjGv5IAnNRwK9PIQOqSwbPsl10oKM07xlC7Sa7zNnFosFL0j4R8ayl
	5TgETjXCHQ4wejUX80GV8xms8EpKQ5nJvz99MsEKZoQa3tZIZ87Rr/B++lr9ZJMRkZTZfpGMZrF
	M30LTZBen8vUOxJfRh1TeHInVOucvb7vxMzeYdvrBsgZru/3UnIRrovppBmQ7gdC1e1z0W1BytB
	0n7Ug==
X-Received: by 2002:a05:6808:1b1e:b0:451:4be5:a90a with SMTP id 5614622812f47-4639f249f7amr423087b6e.51.1770965735267;
        Thu, 12 Feb 2026 22:55:35 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:a3ab:7352:1dc1:6b46])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-40eaee485b8sm6178906fac.4.2026.02.12.22.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 22:55:34 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Igor Raits <igor@gooddata.com>,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 0/3] More fixes for BMC failure handling
Date: Fri, 13 Feb 2026 00:52:12 -0600
Message-ID: <20260213065351.915707-1-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20966-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[minyard.net:+];
	SINGLE_SHORT_PART(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1152E13351B
X-Rspamd-Action: no action

These are in addition to the previous patches for this.


