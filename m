Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA54430A70
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Oct 2021 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbhJQQS0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Oct 2021 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbhJQQS0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Oct 2021 12:18:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D21DC06161C;
        Sun, 17 Oct 2021 09:16:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so10844839pjb.3;
        Sun, 17 Oct 2021 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lYw5pCE0zNrU6J8q4nS26RrdDfNMoAQ5bEAgu6FyY=;
        b=huZFTc12hwErjEmV708pz9npHN0c/F6etjRVedvmqsQKIfhCkmlFr/cjlFh1pYdQur
         MkHCXy18LTVGvxN3QgI8rrVhko3WRr5cdHRINcbWqENXfqNctgLJTXnlGDxBbVuzglUE
         9/ORHPQhoKpIbtos9v66Ure+q5Yzh8E4dfx17rfnj56DRVGMZ48NFMRdqbrKBq6d4yiz
         +1KIqlv1WPnhaTy42/eTqKcqByc0+gVOy8QwOIgOnTilSkRqgRx+Stcttm14P3pZYRNe
         gj9S9UJNmJ5100rWlh+lf45pA9vs5Wo4NPh9PHrqJGGj7JaRtH31kUwz2/r8Pomx+JgB
         LuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lYw5pCE0zNrU6J8q4nS26RrdDfNMoAQ5bEAgu6FyY=;
        b=bEVZmqdbba5MuWCXMmFaoSIuvb84He2EfZqERakQxWrvAKoHiTpiW7jW9o/ZTo78P6
         JIo96hfQVmIt45MVw79GX6WuzKCBnZWEmAWW7cBDDv6yK6871+8mD2ar9+diWVtzYbLe
         HayMwel5XqVf/KLFkW6PhjhRRElXRo+gNuPNNbF2avR2B1SaEgf6FIGRb0vddfKHCvlT
         kVmnrt13xdSZIwCUsBJi3yiBjlaO5UTohFCteE5ONUYK8QKw0zxXedHptbvkZNXHgkN+
         sqH8nAd4sew0Me+53ZvRgLaWT4qVsA4QigC0cZHgU1aITzsvnPvrFSYSQY/mJasqoi3l
         zGAw==
X-Gm-Message-State: AOAM530uV3annXdblunMtiqTilgZasZr0FI7+Wr9XXec4uLe+y+eYzJo
        imO9VesRkCiUoBXMXBJIh+Q=
X-Google-Smtp-Source: ABdhPJy4D1kVJHSvjgoYqFFWfK67+f7kcziXcw85JVrXNW13LxUq0XVkv2DTSSFNqzvhlN17+fkosQ==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr27555159pjb.127.1634487375841;
        Sun, 17 Oct 2021 09:16:15 -0700 (PDT)
Received: from sbwpb-arch.flets-east.jp ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id c11sm16591363pji.38.2021.10.17.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:16:15 -0700 (PDT)
From:   Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] add ccove PMIC i2c address for Microsoft Surface 3
Date:   Mon, 18 Oct 2021 01:15:22 +0900
Message-Id: <20211017161523.43801-1-kitakar@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

Firstly, I'm still not used to Linux patch sending flow. Sorry in advance
if there is some weirdness :-) but I did my best.

I need to use the function intel_soc_pmic_exec_mipi_pmic_seq_element()
with atomisp Image Signal Processing driver on Microsoft Surface 3
(Cherry Trail).

However, it currently fails with the message I added to the commit
message below. I wondered why. The driver intel_pmic_chtcrc does define
the i2c address.

It later turned out that the intel_pmic_bytcrc driver is used on surface3
instead, where the i2c address is not defined. So, I added the address
with the patch I'm sending as RFC in this mail. It's working well.

The question is that, should Surface 3 (Cherry Trail) really use the
intel_pmic_bytcrc driver?

As I wrote in the commit message, the _HRV value of the PMIC is 0x02,
although the _DDN entry describes it as "CRYSTAL COVE+ AIC". So, maybe,
it should rather use intel_pmic_chtcrc? Does anyone know the other
instances where the _HRV value is 0x02 although it's based on Cherry
Trail SoC ?

So, I also tried using the intel_pmic_chtcrc driver instead, with the
following (temporary) change [drivers/mfd/intel_soc_pmic_core.c]:

+	hrv = 0x03;
+
	switch (hrv) {
	case BYT_CRC_HRV:
		config = &intel_soc_pmic_config_byt_crc;
		break;
	case CHT_CRC_HRV:
		config = &intel_soc_pmic_config_cht_crc;
		break;
	default:
		dev_warn(dev, "Unknown hardware rev %llu, assuming BYT\n", hrv);
		config = &intel_soc_pmic_config_byt_crc;
	}

and the function intel_soc_pmic_exec_mipi_pmic_seq_element() worked well
just like with the intel_pmic_bytcrc driver.

I don't mind which driver is used on surface3 for now, considering that
the atomisp driver is working with both PMIC drivers. But I'd like to
hear from maintainers which is better :)

Tested on surface3 with v5.15-rc5.

Regards,
Tsuchiya Yuto

Tsuchiya Yuto (1):
  ACPI / PMIC: Add i2c address to intel_pmic_bytcrc driver

 drivers/acpi/pmic/intel_pmic_bytcrc.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.33.1

