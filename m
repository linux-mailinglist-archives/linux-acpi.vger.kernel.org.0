Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2D43776E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJVM4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 08:56:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54480 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJVM4q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 08:56:46 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 5dd49476cd0eb2b1; Fri, 22 Oct 2021 14:54:27 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D821B66A92E;
        Fri, 22 Oct 2021 14:54:26 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ACPI: Add stubs for wakeup handler functions
Date:   Fri, 22 Oct 2021 14:54:26 +0200
Message-ID: <2615562.mvXUDI8C0e@kreacher>
In-Reply-To: <20211019160401.8296-1-mario.limonciello@amd.com>
References: <20211019160401.8296-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvfeefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopeeurghsrghvrghrrghjrdfprghtihhkrghrsegrmhgurdgtohhmpdhrtghpthhtohepufhhhigrmhdqshhunhgurghrrdfuqdhksegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqghhpihho
 sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheppfgvhhgrlhdqsggrkhhulhgthhgrnhgurhgrrdfuhhgrhhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CC: linux-acpi

On Tuesday, October 19, 2021 6:04:00 PM CEST Mario Limonciello wrote:
> commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> added new functions for drivers to use during the s2idle wakeup path, but
> didn't add stubs for when CONFIG_ACPI wasn't set.
> 
> Add those stubs in for other drivers to be able to use.
> 
> Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/linux/acpi.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 72e4f7fd268c..b31bcc0f4c89 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -976,6 +976,14 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>  	return -ENODEV;
>  }
>  
> +static inline int acpi_register_wakeup_handler(
> +	int wake_irq, bool (*wakeup)(void *context), void *context)
> +{
> +	return -EINVAL;

-ENOTSUPP ?

> +}
> +static inline void acpi_unregister_wakeup_handler(
> +	bool (*wakeup)(void *context), void *context) { }
> +
>  #endif	/* !CONFIG_ACPI */
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> 




