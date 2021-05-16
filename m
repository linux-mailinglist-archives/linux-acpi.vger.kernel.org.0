Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA866381DE0
	for <lists+linux-acpi@lfdr.de>; Sun, 16 May 2021 12:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhEPKTz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 May 2021 06:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhEPKTx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 May 2021 06:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AD3061206;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=Ue7cBVzQyzORe3yy+g9Ws37Hju1tYCf5QU0Lr4jSe6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrjKzev0/LBmP95/FrJiPM06d4ACnZqFAIs4m1B0fR97UQXU7vvoqZrEVfhycOo7N
         7MnhaT8hce+pN3J8+o8jdQE4NZzSXo2DkvoWIksnRILwmf/AlKQbW3MO/F011z7FMH
         KlR2HRP39AGUBglJHzfv73WVRY/+WvoRKhOIE2o2/ur9ongAe6Y94tXKMNaGecQ7gL
         znitvHgmLMaZNnQLpInQCHuxtTxuyb7n/zxkp1MiabYrekRDq5JYf693l0Sv6pJ5WK
         mXqJvglSD7iQyH7xJKNBqNw2g7uw4QsPDxhG8CuYkjPB6/seMpSJzzY5pZdU2AA9D4
         5sbqSO+sSFMjQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o92-NS; Sun, 16 May 2021 12:18:35 +0200
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
Subject: [PATCH v3 14/16] docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:31 +0200
Message-Id: <5c846d672267ceb314978bc775940e6b82ef05c0.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

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
2.31.1

