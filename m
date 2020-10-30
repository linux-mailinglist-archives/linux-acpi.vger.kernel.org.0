Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7C29FBCA
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 03:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3C5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 22:57:40 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:37540 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3C5k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 22:57:40 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2020 22:57:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Zy8++
        6HMOlfcAkxl6HbwZk8onM4/KyltrTc2kPYlsDQ=; b=qDGH/MGM2y9y6zuHZ6Nrj
        jMo6d2EP4WErw8QvA8xPDUj5ab2ZLA45+7oReFdHK2IE2dChRke6AVwbu3ctCR/w
        hDM1mIIjOqNU5vWFUW2lrA+Uj6MMZrw05fZ6t5c2Y++2utuXIUupnY/QlVkdNQqb
        ru4yExm0Jmgfqdmf/M1yfw=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp3 (Coremail) with SMTP id G9xpCgCnD7FsfZtfBPPJJQ--.100S2;
        Fri, 30 Oct 2020 10:41:48 +0800 (CST)
From:   yaoaili126@163.com
To:     james.morse@arm.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org, YANGFENG1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: One question about ghes_notify_nmi
Date:   Thu, 29 Oct 2020 19:41:30 -0700
Message-Id: <20201030024129.15519-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCnD7FsfZtfBPPJJQ--.100S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr15Wr1rXr4xAw1kZF4Dtwb_yoW3tFXE9r
        s0qF18Xryfua15uw429r1DJryfZa10qFyUGr48JrW7GFyF9a45CF4rGr1fGF97X398X3yD
        Kryvq3Wa93W2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0vPfJUUUUU==
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbifAzNG1r6nKTEIgAAsY
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

Hi!

Sorry for my ignorance，When I look in to this code, I am totally condused.
The Line 1136 has guarranted that Only one NMI will enter following code I think, Is
this right? if so, what is ghes_notify_lock_nmi going to pretect?
Can any one help correct me?

   1131 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
   1132 {
   1133         static DEFINE_RAW_SPINLOCK(ghes_notify_lock_nmi);
   1134         int ret = NMI_DONE;
   1135 
   1136         if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
   1137                 return ret;
   1138 
   1139         raw_spin_lock(&ghes_notify_lock_nmi);
   1140         if (!ghes_in_nmi_spool_from_list(&ghes_nmi, FIX_APEI_GHES_NMI))
   1141                 ret = NMI_HANDLED;
   1142         raw_spin_unlock(&ghes_notify_lock_nmi);
   1143 
   1144         atomic_dec(&ghes_in_nmi);
   1145         return ret;
   1146 }

Thanks
Aili Yao

