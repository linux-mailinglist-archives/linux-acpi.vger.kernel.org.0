Return-Path: <linux-acpi+bounces-2171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E3806FDF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAF1F211DE
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316E36AE8
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Dec 2023 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/OKQCGg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EE12B;
	Wed,  6 Dec 2023 02:44:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286e05d9408so572440a91.1;
        Wed, 06 Dec 2023 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701859488; x=1702464288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5B5d2/8qxaPjHZlns3KcRSngp7JdBdKI506/CONwgk=;
        b=b/OKQCGgwQc8Hr3M5I2qojbEa8HFx3XHxyKmhoZ4X/KPRU5EwcZLmJKyjrUeXIvUev
         Blp5XdZztB4+9Ssap+UqLnOfqzYTBkkkAjqt1L5crraCb3i8q1JMY0qn0ai5+k/a4BKL
         7kgV29bsfZ3meTLAqw4I6IRhi97I1W2u+rVFb3tOLvMjddoQaXq4fYh9kbMaoMYAwveu
         T8MPYydJ36VSy1pp1UYFKWRcSqpCj9PasE/vvFcipn4K+R3aDX12pMZLF+GqFQAtlKie
         WpN8cH9mCXToJrgqilLRH+ngAFzBIxXFm92HbVRdABnBb5UmTT2cJGplMSLxrn1MUIyc
         3tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859488; x=1702464288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5B5d2/8qxaPjHZlns3KcRSngp7JdBdKI506/CONwgk=;
        b=dQbdiQL+ozzqXDdKlHL8DgSlcaBvAuM/Q6o+CSiCoF3n6C/25ICs+66CGRfp2K270E
         I/wox4vhLeeguMgGuauasIq155AHHDzI3uMZfY1HnWV7/RDWPsooWYzXAwug2mGOUAAT
         WTvRi+EL3TYpEXa8Q8rZJurwU7nmLY2WlxELO4nNdIfRXnr/EedVpcQJibO+2Tv1vH2O
         qYV3aWBLnGgiJUGbdWVKopNoEYKEl7D1So/I4RsmlZflr71kMJQn9Wzukcf7UQONp+0b
         rutAL87dEqqhC8kRfw6fD3B2nex9xnstHbulhGdyEXpty1UJEizVu4Bg7kePj5CdLVyU
         s0pQ==
X-Gm-Message-State: AOJu0YyBEspCftUK6MgzM2KJGqQviTi/TQFv2KVWpieMjo8s9zTa+FvE
	XPEP4W5iDL++XPEmtw2SbKT9347or4c=
X-Google-Smtp-Source: AGHT+IGWci80b+s+FKtQ0vgvKG11CNyQku53N4VrBf95PjPh+wFgPvrb0biGtdgc5OxF8oGoNIzP5w==
X-Received: by 2002:a17:90b:3e8c:b0:286:975f:7e36 with SMTP id rj12-20020a17090b3e8c00b00286975f7e36mr996284pjb.12.1701859488348;
        Wed, 06 Dec 2023 02:44:48 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090a2a4b00b00286596548bcsm10020811pjg.37.2023.12.06.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:44:48 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/3] ACPI/NUMA: Optimize the check for the availability of node values
Date: Wed,  6 Dec 2023 18:43:17 +0800
Message-ID: <20231206104318.182759-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206104318.182759-1-ytcoode@gmail.com>
References: <20231206104318.182759-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first_unset_node() function returns the first unused node in
nodes_found_map. If all nodes are in use, the function returns
MAX_NUMNODES. We can use this return value to determine whether there are
any available node values in nodes_found_map, eliminating the need to use
the nodes_weight() function to perform this check.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 drivers/acpi/numa/srat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 9d2d0deb256e..d58e5ef424f2 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -67,9 +67,9 @@ int acpi_map_pxm_to_node(int pxm)
 	node = pxm_to_node_map[pxm];
 
 	if (node == NUMA_NO_NODE) {
-		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
-			return NUMA_NO_NODE;
 		node = first_unset_node(nodes_found_map);
+		if (node >= MAX_NUMNODES)
+			return NUMA_NO_NODE;
 		__acpi_map_pxm_to_node(pxm, node);
 		node_set(node, nodes_found_map);
 	}
-- 
2.43.0


