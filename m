Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA65D378276
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhEJKfu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 06:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232672AbhEJKfA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 06:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9257561629;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=PrJsz3gAKE66Zm+lD6GkI1q1TUNOZ25Wq6nCaiV0SIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsHqD3QhWJuKICCaIOX3af0aTgEG5TP7eC9kkpaD1Q2yLQT0iKTIfF2AvCskL2H/6
         DG3btQx4orl4tNjS2wsAnRAPMFGcUQUcIxAPgEzj5wLUEsU2OgasrzQ2JH4TI2PsJG
         C/lnnAl1cgJ/diBb6EqJLd/AKywFDcfLBThmS+M2AU7BNEmicVF8f1217MO3nwpSiE
         HmS10Jo6UJekoQdZaSBi+WhYO0YAvepp6IWt7H7oWUFxaKf9njWePa+CAUA/ikmKuh
         wQiUF4gICXt8Zy+Tuk5No3zwEwahxMcnnlwmnoFrC1KVx3qhgrWNGZZVuRAUudmyX5
         8WA4nD5ajmPWA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYS-M8; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 51/53] docs: firmware-guide: acpi: dsd: graph.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:27:03 +0200
Message-Id: <3c69174e0f6d54c21ffca8203df1db467388bcf7.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 7072db801aeb..954b99ec6b77 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -159,7 +159,7 @@ References
 
 [2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
 
-[3] Documentation/devicetree/bindings/graph.txt
+[3] Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
     https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
-- 
2.30.2

