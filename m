Return-Path: <linux-acpi+bounces-15980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B751AB3222D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3DAE7073
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1072BE7DF;
	Fri, 22 Aug 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBwwXIJ0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB229A326
	for <linux-acpi@vger.kernel.org>; Fri, 22 Aug 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886535; cv=none; b=KDKrRLQWP1hu7lHWTg1Snp1/o42iwM/Ujg8Vs3sSwdNFCyTyIXe6q0LVrHgGoVR8inaK8eoD+tNeQoc6RiehDyuoXLjfdSBc5fXTVfIcYHUpdG+8e1lT5YMYUrx4W3HoWSYiq75yugjXKjujOdOajtOcyfHhzZFbw6QSmMT1SA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886535; c=relaxed/simple;
	bh=V94dfA16La60dmKehf08TTEBcoaCXjBACbj1AhKkruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtfO5ayeMQTDsTI5uXEGqwgayUQEkEnnz+TmlNnzoYvSoHDagOpBkGibV0pUovEvV+W+912cKOAjnQfQuVNKvj3OfchgTqRucx/P59tletXediNBxeY4Z9FCG1RYnMYZVKJJ4D2581oMDg3mxmoGbBEckb39fjlvHsr3jaXMfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBwwXIJ0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7aea37cso316895066b.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Aug 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1755886532; x=1756491332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=LBwwXIJ0UcKfsZ6Fn4z7xbi0+AkXaoPoT8WJHBeVUngWegUr8qwNsXZ8FtEJghznX5
         Qi/K2L5EogfbxdnzItAPc9qh4Z9zDbTZjfnUAc3JJ3ysTq/OW+N9Lm/cEwshCBkJ8KgF
         aI0xJdoD6vfoPvKXk0Ztl2JLMMEpXXFPiZdKAkKcmaD0kKJ/zZF8KBJQa3GLqFgcIMZF
         FyBjQJbu4gjGx7Bmj7xoCMqOohmb1v7Tc5+0vno5kYGkEOREWvyoz6U3jmG0njuxeHbE
         n8ojF8pvjXjzpRzSzwHCfiADF/uVH/mOUUj+syX6OpDqbuTx10pi2pRmyot4qbKahSy6
         NUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886532; x=1756491332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYWGWVCN0O70uGnBCPPQFCaIo3hbXhoMScsfqxRs/Kc=;
        b=doJXj6FJ9hhKyW+k243e993LLK4dENSnOX6zDc1ek8EuE6tDoKiQMMUZSS1d4MVgMJ
         /km16XCZgAG+zesj0MoMFGS23UNj5jd0nSH74FGwfKA8DGbT92jWDvr5dbnNrIhm+YJ8
         TN+bwfFe7JgrfXha/46WwX5UvFLv5IPSvH5tmjPtz0lyqtKhNtNFHj9H/X9rUDb3dBRk
         q75gjeRMVBWamIDkr5xnAxV+AvNMIKqooKTkFnOgGhcLEVCPfg3hIPTLcKKi0HP3R/Tp
         hHeIKIADChsxvLdopbn6yDUbcRnDmE+imZP/Ta2s4BR0oTAdzYVi1t6L2wP+aH2wAxtL
         rENA==
X-Forwarded-Encrypted: i=1; AJvYcCVrQwrwv3bvcr77Cisx8wyIcl+dDFEU08ydOUr7PLuQU5aeh9sboa0VR/mu7lNlkeToAwrVhrPphVi8@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpkoY1Uo1+vtBnApX66F5oVI8D1lQS1NeWm8orv18qXNDDWQL
	l/UKDQOnHc2GXrnGV8JBmP27GzSbsfycPJAebz3OG5YEt7Psok0CJf6tROLX0GXpaSI=
X-Gm-Gg: ASbGnctLPOmdTgjnnzsWWMC883tK20ZyCPi4LjxEbbqknuxtTeh3B0jGYI9ZKxXnqkY
	+pkpVXY7mbbz4yUrMvLNUZom6l9prT2hNbvCn1wvVaV0VKgCqlckXaQnwmn8/tTvrZcU9pa90Ba
	YRz216pNXVYoNNGySmluxtn0kZ7s7WlyduwLctqj1/FjLX6zVTQHXVO4Obben8NL/6BS0uVw9ji
	6PGShenGLFK20WvAeWyKy5YWJLa7vFKzsVhcIVEHpnFldq7Jeoy7qYE7hLs/M0YGEn0KGYJx0fz
	l/W6o06F0/XgU46Z3z14OH0Uoc+9zIt+DyRpljIpy+aE0wzuZUuwoPQsztMsj/matabIymyQjwP
	9je7oXhhx+Fr05/LYR1LBgJovN3AjAeoIzKuWC/72RzURiN9i/k6Xw19w8dc=
X-Google-Smtp-Source: AGHT+IFi/UqB7Uldrm+9VbwlcvS/K9grf+HFQGwUPWY0Y+SNRhjWVo0c6zi2HNxzYpUPo9jAOLRO3A==
X-Received: by 2002:a17:907:7213:b0:ae0:d798:2ebd with SMTP id a640c23a62f3a-afe295c0e07mr334350266b.35.1755886532255;
        Fri, 22 Aug 2025 11:15:32 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afe49314f63sm16474966b.97.2025.08.22.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:15:31 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: Smita.KoralahalliChannabasappa@amd.com,
	adam.c.preble@intel.com,
	agovindjee@purestorage.com,
	alison.schofield@intel.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	bp@alien8.de,
	chao.p.peng@intel.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	ira.weiny@intel.com,
	james.morse@arm.com,
	jrangi@purestorage.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	oohall@gmail.com,
	qingshun.wang@linux.intel.com,
	rafael@kernel.org,
	rhan@purestorage.com,
	rrichter@amd.com,
	sathyanarayanan.kuppuswamy@intel.com,
	sconnor@purestorage.com,
	tony.luck@intel.com,
	vishal.l.verma@intel.com,
	yudong.wang@intel.com,
	zhenzhong.duan@intel.com
Subject: [PATCH v5 0/2] PCI/AER: Handle Advisory Non-Fatal error
Date: Fri, 22 Aug 2025 12:15:20 -0600
Message-ID: <20250822181520.12394-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250822165112.GA688464@bhelgaas>
References: <20250822165112.GA688464@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 11:51:12 -0500, Bjorn Helgaas wrote 
> I'm terribly sorry, this is my fault.  It just fell off my list for no
> good reason.  Matthew, if you are able to test and/or provide a
> Reviewed-by, that would be the best thing you can do to move this
> forward (although neither is actually necessary).

It seems for pci there is always a massive list of things in flight..
Difficult for any mortal to keep up with. We pulled the patch into our
kernel & have started testing it. I'll sync-up with my team internally to
see exactly what the plan is & how long we think it will take.

Cheers!
-Matt

