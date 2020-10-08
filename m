Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D7286EDC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJHGxH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Oct 2020 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGxH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2020 02:53:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FDEC061755;
        Wed,  7 Oct 2020 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BKPfVq1WNjEP482JRlMf/O/7ehMr1L/SqAOw+UYjUwE=; b=HyXdCXS8uEhcA2dJEClupFhOz2
        LtB+vTMDvLfw3IzGcJDivlJDj6Wspmd9ZbVS3URjMkWmtP4C0S3X1G08RPg/uEidfXs87/6h+YP5j
        ylDby8rfMPx5sazy4N43fKD98qEldElgYco30Nno+lRvu8TV3HH/Ltai0ibJUKZYunzlVZXcxNtjS
        uoxhN+pFlXoplNTSNqnAaqxtn/nvsvrWKBlLLJVS6YbL5+ms4cKjmp2OPwUr3H1bktKRygGefgUTx
        2B2M0Qhj0oBO7uHS80HQRKwV/pJ4w8iTryUm5T5YLcmStvXdicNqFHQhPk6GexoSa+zUX0T3Bu1KG
        Bfq/e+UQ==;
Received: from [2001:4bb8:184:92a2:5831:14b2:58c8:625e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQPnU-0000Sl-JV; Thu, 08 Oct 2020 06:53:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pnp: remove the now unused pnp_find_card function
Date:   Thu,  8 Oct 2020 08:53:03 +0200
Message-Id: <20201008065303.1486028-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All user of the pnp_find_card compat wrapper are gone, so remove
the function as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/admin-guide/pnp.rst |  4 ----
 drivers/pnp/isapnp/compat.c       | 23 -----------------------
 include/linux/isapnp.h            |  6 ------
 3 files changed, 33 deletions(-)

diff --git a/Documentation/admin-guide/pnp.rst b/Documentation/admin-guide/pnp.rst
index bab2d10631f00d..3eda08191d139a 100644
--- a/Documentation/admin-guide/pnp.rst
+++ b/Documentation/admin-guide/pnp.rst
@@ -281,10 +281,6 @@ ISAPNP drivers.  They should serve as a temporary solution only.
 
 They are as follows::
 
-	struct pnp_card *pnp_find_card(unsigned short vendor,
-				       unsigned short device,
-				       struct pnp_card *from)
-
 	struct pnp_dev *pnp_find_dev(struct pnp_card *card,
 				     unsigned short vendor,
 				     unsigned short function,
diff --git a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
index 6c845b6283163d..035e9509248968 100644
--- a/drivers/pnp/isapnp/compat.c
+++ b/drivers/pnp/isapnp/compat.c
@@ -21,28 +21,6 @@ static void pnp_convert_id(char *buf, unsigned short vendor,
 		(device >> 12) & 0x0f, (device >> 8) & 0x0f);
 }
 
-struct pnp_card *pnp_find_card(unsigned short vendor, unsigned short device,
-			       struct pnp_card *from)
-{
-	char id[8];
-	char any[8];
-	struct list_head *list;
-
-	pnp_convert_id(id, vendor, device);
-	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
-
-	list = from ? from->global_list.next : pnp_cards.next;
-
-	while (list != &pnp_cards) {
-		struct pnp_card *card = global_to_pnp_card(list);
-
-		if (compare_pnp_id(card->id, id) || (memcmp(id, any, 7) == 0))
-			return card;
-		list = list->next;
-	}
-	return NULL;
-}
-
 struct pnp_dev *pnp_find_dev(struct pnp_card *card, unsigned short vendor,
 			     unsigned short function, struct pnp_dev *from)
 {
@@ -86,5 +64,4 @@ struct pnp_dev *pnp_find_dev(struct pnp_card *card, unsigned short vendor,
 	return NULL;
 }
 
-EXPORT_SYMBOL(pnp_find_card);
 EXPORT_SYMBOL(pnp_find_dev);
diff --git a/include/linux/isapnp.h b/include/linux/isapnp.h
index 11edb2109a68f6..dba18c95844bde 100644
--- a/include/linux/isapnp.h
+++ b/include/linux/isapnp.h
@@ -75,9 +75,6 @@ static inline int isapnp_proc_done(void) { return 0; }
 #endif
 
 /* compat */
-struct pnp_card *pnp_find_card(unsigned short vendor,
-			       unsigned short device,
-			       struct pnp_card *from);
 struct pnp_dev *pnp_find_dev(struct pnp_card *card,
 			     unsigned short vendor,
 			     unsigned short function,
@@ -92,9 +89,6 @@ static inline int isapnp_cfg_end(void) { return -ENODEV; }
 static inline unsigned char isapnp_read_byte(unsigned char idx) { return 0xff; }
 static inline void isapnp_write_byte(unsigned char idx, unsigned char val) { ; }
 
-static inline struct pnp_card *pnp_find_card(unsigned short vendor,
-					     unsigned short device,
-					     struct pnp_card *from) { return NULL; }
 static inline struct pnp_dev *pnp_find_dev(struct pnp_card *card,
 					   unsigned short vendor,
 					   unsigned short function,
-- 
2.28.0

