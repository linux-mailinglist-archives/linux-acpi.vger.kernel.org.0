Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D94763669
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jul 2023 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjGZMgO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jul 2023 08:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjGZMgL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2023 08:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6631BFB
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jul 2023 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690374925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VQNsoN15VSw81frw456ZhybsYXinxgE33D7f+mdmNP0=;
        b=EoWo3PlU2Z+EPdRsuXAWhnuYd+ii2tfKi0u1ekj2nRz5XzwrzMYQl8WSx/MS7NdWz0fWz4
        IASnYt9H0P5ZV17RuPmSqqQ4/gsDwDWe5qkpHLfmtxPc1vyKhKEQCouxgHUZxa3bhHcBs9
        fKlY3GN/jjDc+rHsz9taxbkgXdMeHOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-SrrMs66UNX2UYdpXEU-7sQ-1; Wed, 26 Jul 2023 08:35:22 -0400
X-MC-Unique: SrrMs66UNX2UYdpXEU-7sQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7259B88D4E2;
        Wed, 26 Jul 2023 12:35:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45413492B01;
        Wed, 26 Jul 2023 12:35:20 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 0/1] PCI: acpiphp: fix regression introduced by 'Reassign resources on bridge if necessary'
Date:   Wed, 26 Jul 2023 14:35:17 +0200
Message-Id: <20230726123518.2361181-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


The patch fixes regression introduced by
  commit 40613da52b13fb ("PCI: acpiphp: Reassign resources on bridge if necessary")

I'm not sure about proper process for PCI tree, but is it's not too late
the patch shall replace the revert (from branch for-linus)
  commit f3b827a92f7d54 ('Revert "PCI: acpiphp: Reassign resources on bridge if necessary"')

Igor Mammedov (1):
  PCI: acpiphp:: use pci_assign_unassigned_bridge_resources() only if
    bus->self not NULL

 drivers/pci/hotplug/acpiphp_glue.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.39.3

