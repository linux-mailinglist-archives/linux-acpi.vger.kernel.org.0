Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613833A9271
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 08:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhFPGaM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 02:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231657AbhFPG3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E09A6140F;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=B5lTEnXkGEyVgmsK8p6BhCFjJdgDkkDfTb1jiWTpZPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gafOlhgjRhVyNH90XnJj8SG7CJs2eqUjt2tE6b8W0glg9tYsMP5cEAIAVVWDA0UdL
         rih//xbEUWgjlzl1GCY5gEHvAE6ROzHC7t6Bktx/HWnLrLtBzMwt3ywvmto+dD8/UY
         Fm2dPm8TwEpKfjSO2eirQjP1CjuKRtqQdAF2EvcfXUeogdDL08SH7H8ePuL1U0cHq5
         Swz/p8cdy/0A/v6onpl1UPrfan50B76M9LBrRwCbvQngo6wgEC8kvbCCja96UrExeu
         c19qWgtzQN2MDxSbwEU54sVxXdyx3toV6JFK9fpEFMq4dPQO8e5Zsw3g692f+5zjdo
         t+m07Ve8x0VyA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJO-OO; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/29] docs: firmware-guide: acpi: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:32 +0200
Message-Id: <7162043c18f1ea96c446b332400e44e8087ba142.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../firmware-guide/acpi/dsd/data-node-references.rst       | 3 ++-
 Documentation/firmware-guide/acpi/dsd/graph.rst            | 2 +-
 Documentation/firmware-guide/acpi/enumeration.rst          | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index 9b17dc77d18c..b7ad47df49de 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -79,7 +79,8 @@ the ANOD object which is also the final target node of the reference.
 	    })
 	}
 
-Please also see a graph example in :doc:`graph`.
+Please also see a graph example in
+Documentation/firmware-guide/acpi/dsd/graph.rst.
 
 References
 ==========
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index 7072db801aeb..4341299aa937 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -174,4 +174,4 @@ References
     referenced 2016-10-04.
 
 [7] _DSD Device Properties Usage Rules.
-    :doc:`../DSD-properties-rules`
+    Documentation/firmware-guide/acpi/DSD-properties-rules.rst
diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 9f0d5c854fa4..18074eb71860 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -339,8 +339,8 @@ a code like this::
 There are also devm_* versions of these functions which release the
 descriptors once the device is released.
 
-See Documentation/firmware-guide/acpi/gpio-properties.rst for more information about the
-_DSD binding related to GPIOs.
+See Documentation/firmware-guide/acpi/gpio-properties.rst for more information
+about the _DSD binding related to GPIOs.
 
 MFD devices
 ===========
@@ -460,7 +460,8 @@ the _DSD of the device object itself or the _DSD of its ancestor in the
 Otherwise, the _DSD itself is regarded as invalid and therefore the "compatible"
 property returned by it is meaningless.
 
-Refer to :doc:`DSD-properties-rules` for more information.
+Refer to Documentation/firmware-guide/acpi/DSD-properties-rules.rst for more
+information.
 
 PCI hierarchy representation
 ============================
-- 
2.31.1

