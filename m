Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952A71A819E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Apr 2020 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440276AbgDNPK7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437268AbgDNPKx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Apr 2020 11:10:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F8C061A0C
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2020 08:10:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x66so13527933qkd.9
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2020 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIZ0DCpY1Pp7B3wv2bPDU+0HXY5iXLSvClXRWjLvkkQ=;
        b=fCyc053SB2qlgTuaFkp8z+8t4vZfLWn+qcVeK8qtwb2TV8BPij2WpcZiPHnR0G5kSj
         KSZGjCkejypBSyNupM0sPMCWG+FYfehmLTI5UuFPrdO+1+9YdDpOJMSzo+hSfHs1sH8n
         OFshk0+XJAKq4fp2ESGHS3KegWExzp4qSPX6qeCC4jl/aljnosjQ8p2izyxr9Jo6ns9r
         CXPyEetntLikspC62dFEggL+vTT11TmQIZeKE7tDLzzD5Eqj+a9qPViBbc8/fCQPCHqw
         xxhQDVonAdDe0j+x2mDKJWU9NAh3SNaDfQd6U5sXlNWBbE3M8zYgIpoy4sE0tv8dnCEB
         7NuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIZ0DCpY1Pp7B3wv2bPDU+0HXY5iXLSvClXRWjLvkkQ=;
        b=T/9FUMgocTliesyEE+wtoM19RmyCIpGZev4AaDWmvVjLdBBGB1mX3M3vofE2fTCzUZ
         X4RNfxp6X9WnLHD9BP3SnBzSU7ybU0CVfRFpxQHYyqgWLpo0iUemGmI6SacvSHZVbaGC
         DbiXwYPlP2dKzWQZZTvM79Q6OJ3GiqG0/baLN7zQy44Ve8AEWn03JPvoLqprWRo857Lp
         ZLflRe7zJDX2SV9ZkjUb5ndm3TuDg/uCqaI+2UoFLxKRs5UNi5MYqsnSeGqqvX4WZG+a
         OSW1fEZMleivpnnT+qc/AROttsUBGeXx2mD5QWBONM228zITZ7Skqqp5+AtcGWFcZa+v
         Q8FA==
X-Gm-Message-State: AGi0PubaXNiNaXBO7mpXHZ5oCUmRsdgWc793p4/lZEEarSWzqhZDomI3
        ucfMrYDae9agPbssWws9xgYTgEmh5jy3eA==
X-Google-Smtp-Source: APiQypLW4lrPzcOv/3ifsnmULX8xFPu+h/Ghs2yhvEwKGx0LbKvxPM23+720Zfx1vnwLDmnHb+7sQg==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr1748486qkl.226.1586877052183;
        Tue, 14 Apr 2020 08:10:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m26sm11309900qta.53.2020.04.14.08.10.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 08:10:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOND8-0004z0-Ai; Tue, 14 Apr 2020 12:10:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] pnp: Use list_for_each_entry() instead of open coding
Date:   Tue, 14 Apr 2020 12:10:50 -0300
Message-Id: <0-v1-f68011aff1f8+d8-pnp_gcc10%jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Aside from good practice, this avoids a warning from gcc 10:

./include/linux/kernel.h:997:3: warning: array subscript -31 is outside array bounds of ‘struct list_head[1]’ [-Warray-bounds]
  997 |  ((type *)(__mptr - offsetof(type, member))); })
      |  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/list.h:493:2: note: in expansion of macro ‘container_of’
  493 |  container_of(ptr, type, member)
      |  ^~~~~~~~~~~~
./include/linux/pnp.h:275:30: note: in expansion of macro ‘list_entry’
  275 | #define global_to_pnp_dev(n) list_entry(n, struct pnp_dev, global_list)
      |                              ^~~~~~~~~~
./include/linux/pnp.h:281:11: note: in expansion of macro ‘global_to_pnp_dev’
  281 |  (dev) != global_to_pnp_dev(&pnp_global); \
      |           ^~~~~~~~~~~~~~~~~
arch/x86/kernel/rtc.c:189:2: note: in expansion of macro ‘pnp_for_each_dev’
  189 |  pnp_for_each_dev(dev) {

Because the common code doesn't cast the starting list_head to the
containing struct.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/pnp.h | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

Compile tested only

(resent with mailing list in cc, sorry)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index b18dca67253d66..db41156b1b4044 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -220,10 +220,8 @@ struct pnp_card {
 #define global_to_pnp_card(n) list_entry(n, struct pnp_card, global_list)
 #define protocol_to_pnp_card(n) list_entry(n, struct pnp_card, protocol_list)
 #define to_pnp_card(n) container_of(n, struct pnp_card, dev)
-#define pnp_for_each_card(card) \
-	for((card) = global_to_pnp_card(pnp_cards.next); \
-	(card) != global_to_pnp_card(&pnp_cards); \
-	(card) = global_to_pnp_card((card)->global_list.next))
+#define pnp_for_each_card(card)                                                \
+	list_for_each_entry(card, &pnp_cards, global_list)
 
 struct pnp_card_link {
 	struct pnp_card *card;
@@ -276,14 +274,9 @@ struct pnp_dev {
 #define card_to_pnp_dev(n) list_entry(n, struct pnp_dev, card_list)
 #define protocol_to_pnp_dev(n) list_entry(n, struct pnp_dev, protocol_list)
 #define	to_pnp_dev(n) container_of(n, struct pnp_dev, dev)
-#define pnp_for_each_dev(dev) \
-	for((dev) = global_to_pnp_dev(pnp_global.next); \
-	(dev) != global_to_pnp_dev(&pnp_global); \
-	(dev) = global_to_pnp_dev((dev)->global_list.next))
-#define card_for_each_dev(card,dev) \
-	for((dev) = card_to_pnp_dev((card)->devices.next); \
-	(dev) != card_to_pnp_dev(&(card)->devices); \
-	(dev) = card_to_pnp_dev((dev)->card_list.next))
+#define pnp_for_each_dev(dev) list_for_each_entry(dev, &pnp_global, global_list)
+#define card_for_each_dev(card, dev)                                           \
+	list_for_each_entry(dev, &(card)->devices, card_list)
 #define pnp_dev_name(dev) (dev)->name
 
 static inline void *pnp_get_drvdata(struct pnp_dev *pdev)
@@ -437,14 +430,10 @@ struct pnp_protocol {
 };
 
 #define to_pnp_protocol(n) list_entry(n, struct pnp_protocol, protocol_list)
-#define protocol_for_each_card(protocol,card) \
-	for((card) = protocol_to_pnp_card((protocol)->cards.next); \
-	(card) != protocol_to_pnp_card(&(protocol)->cards); \
-	(card) = protocol_to_pnp_card((card)->protocol_list.next))
-#define protocol_for_each_dev(protocol,dev) \
-	for((dev) = protocol_to_pnp_dev((protocol)->devices.next); \
-	(dev) != protocol_to_pnp_dev(&(protocol)->devices); \
-	(dev) = protocol_to_pnp_dev((dev)->protocol_list.next))
+#define protocol_for_each_card(protocol, card)                                 \
+	list_for_each_entry(card, &(protocol)->cards, protocol_list)
+#define protocol_for_each_dev(protocol, dev)                                   \
+	list_for_each_entry(dev, &(protocol)->devices, protocol_list)
 
 extern struct bus_type pnp_bus_type;
 
-- 
2.26.0

