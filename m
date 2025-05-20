Return-Path: <linux-acpi+bounces-13828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F3ABE0DB
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 18:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8741625B7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90426A1CC;
	Tue, 20 May 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNJWyhKi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A924E010
	for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758946; cv=none; b=btCk3zp93Uer9UY3+tJp01c4FqzlP9Pb1aZN7AIS4mrPdcASoYZKK87xcjV41N/DQz1qfKx/efuVsYr/SCelTlJApL/nF+GnRlg83WovbZ/Cee9LW7OQMo87/ffgxIFPMzfS0nETRmWubjRVYN+5kE+jrN+QJwGgXT8thU1roWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758946; c=relaxed/simple;
	bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxyJBb9PuzzLwbSr8UFKF0Frmc/kOb6/r872myx16d6A1AyCC5Qy84ZMlJBBgxO0kuqAT8HMrdxrwyzLNdYdNxo7H6+r5DoTZWsxBA0FvwDUoO2aOXZwetWDu1hyLvKydvPgTyYTQZh+5kwZswJnlepdZVchpHcxnUFW4vbANng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNJWyhKi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so46907045e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 09:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758943; x=1748363743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
        b=jNJWyhKi3DvUb9qOmEfDPgIMDQB5h0MkGdRSaDPcSYlhamgMuR67NAFaj+y+sUcOlU
         wX3LSIZpTN/TsaFzaf0ZBq7L4DyzgmxA4SVrJw9xKUFWyf8jT+5naA4TXGT0LH/AxbMh
         e39WbqM1yFQ7r3ofT3KE352BaRuU4yG0P8SJCwJOc2Ke1aobgJGtiM6wDRl2HsmayRg+
         SSkkaG5nPEkSbybsc6DuHVQ1m6u6FaN4KzFHk1SvdFwGHK5XgnR/HBhQa1t5IEStijYP
         0I2/5oJJlf6oVReEOCet0fly7Yk6pT8rYVO5gkIiVCRWAVYCWClVcHSHvHs7YOWdpSNd
         uXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758943; x=1748363743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0PfTfMmru6XtZg7/P7iWYe3RnaZ5NwcijI/RTSpFVU=;
        b=Lcyr5g1wq1Cid/DrsDsbUKduW0wOjoEcaQISWG123kCmZ1sNkwkpytJx0kfAnoucVH
         MX7l7ijv/g6td8KT2YNxNnUAYbuneyQHgNKOHCdwEljr/M611/DWhsHXYSxlNHAyqJ/o
         ZHzhSAei2eZY6j0UhnDrB94DGfGNw1zRCR73voxHRIQFmGxIRh61hVfNk1ljVSB7R6WH
         mBr0ku6LjDfi3AkU0c6GOlb3mBCEu5XrgQ+sgGsYAs0oWQgwtxsWkLiEOzFcrunxKHw4
         lF8GEhJCP14IRVjSqg+56UG/1Ki4zyLm/odJBwZqnTS830s26WhGlu/NHkKKA90/WcX7
         Q+uA==
X-Forwarded-Encrypted: i=1; AJvYcCX3MV/JT/KR1L1oJRA/W1Wc6EJDJmVrrCU7cq7uwBd1C9kD0SRhZxpFGyV37c+ZE6dDAsAd7QzB1d5q@vger.kernel.org
X-Gm-Message-State: AOJu0YzDmLpej8eYrnHL2ZNnj6NnEY7GWuXkkBI3AQzUGsOpvMGO5iKp
	bXtkHVGPPRsTbOZJ/JsEv6kodQVXBE06TafA6JHl7wzYFdIAFjX6WaZG9h+3MNOt
X-Gm-Gg: ASbGncuxFUgvxJ1NPEXqwgEslV8N6vXitaUkzD5X3nxOGbE7Dw6W2tLRtHmOFj6s1Tu
	/EEYhDsuGwmrnS9TD88QsiqjV22wew0471l1vUl419NJAQTCW2+8NydDEfjQGSlQawB7lvN9awc
	dEAwhdWOy7tPfJDDiymGglAuZ+IgzNLNXqh74Nl+X/SSzcJiTkbANkLf/VI0fzp7oFXqJ0OwVbw
	j9/I9ZWgaw7Mfv7CyDPCxFzkz9MiEnkE1Ex81O796LHLnrD6Y5rsODRKNP0KDPiRpJU4PHwCNdm
	b+vGh2efApfeeUKgA3CpnpMtR6JVgF6U5ZVXq/C2Z0amt9HXNpxdRTn11tQTgGQ=
X-Google-Smtp-Source: AGHT+IH0BSz4RjlodJowlGibph9G6OBJbinuQbQBcy85MNVysOtD3B+YBfEIqxAYnCdgCYfSiR0cyw==
X-Received: by 2002:a05:600c:1f82:b0:442:dc6e:b9a6 with SMTP id 5b1f17b1804b1-442fd64e349mr192530105e9.17.1747758943067;
        Tue, 20 May 2025 09:35:43 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm36321295e9.35.2025.05.20.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:35:42 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: oliver.sang@intel.com
Cc: acpica-devel@lists.linux.dev,
	goralbaris@gmail.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH acpi] Replace strncpy with strscpy
Date: Tue, 20 May 2025 19:35:40 +0300
Message-Id: <20250520163540.6893-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202505191014.718ca1d6-lkp@intel.com>
References: <202505191014.718ca1d6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Rafael I dont understand your question. This patch replaces
strncpy which is vulnerable with strscpy. As it stated in Link I shared.
It seems it works to fix somethings. Thank you for your test effort Oliver :)

Best Regards,
Baris

