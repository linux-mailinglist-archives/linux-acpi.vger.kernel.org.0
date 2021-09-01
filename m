Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CA3FDD99
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 16:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhIAODm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 10:03:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56352 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244101AbhIAODi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2021 10:03:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 622D31FF0D;
        Wed,  1 Sep 2021 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630504958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YWz5sNWamvYmJmRVbeWQfiyvjQAJWEM0VuSCMI1weFc=;
        b=g+FYx89WzcJDyvB1kMcjBOT9purH20HogXDxHs8yc1c0LhdmsGSJF0yuKDkbCey8Qr2V8U
        mt4uHQ+DymLgDo04pjpot5m7pUiXvyN4biSnUfOOIJPUbH/SpDDEGLFJvvyJ5FBcAryItl
        ka/by0RyvQlGKANOJMGsJmdhR+VaOXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630504958;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YWz5sNWamvYmJmRVbeWQfiyvjQAJWEM0VuSCMI1weFc=;
        b=OrULDyeNAYUavM+opIBGLOlV7M6dVseZk462TdqeGcx4j9bUqM6Sv2EmQxIU4Dua2dW3So
        kiTZeyAW0tdg7JBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1360C13AD6;
        Wed,  1 Sep 2021 14:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gRjAAf6HL2HWZgAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Wed, 01 Sep 2021 14:02:38 +0000
Date:   Wed, 1 Sep 2021 16:02:34 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: TPS68470 PMIC config option
Message-ID: <20210901160234.0e3e24b2@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
