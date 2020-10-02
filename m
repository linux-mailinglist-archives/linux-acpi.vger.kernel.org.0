Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08626281DC2
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJBVnh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Oct 2020 17:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVnh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 17:43:37 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E8EC0613D0
        for <linux-acpi@vger.kernel.org>; Fri,  2 Oct 2020 14:43:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g72so4002504qke.8
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eG6HESFLPWn8glvX0A6+C501emaqPJYVDqCfVaG7yDw=;
        b=n1wb1zCunGsc0oI/6bMmPIIwYAQlOLNVhxr6dXH69cnVnxAfIkyJJTwG6jnSUv3MXU
         b9ryAnxnsQTrh/tQfejZeuZ8vLTVWTIDjODrxGtn+pgaV15Op6AfNs7E1BeVYgUKc+w9
         tkF1QtqvExTtb5Zifc2wjcnfyaTOHr1uGE2hKQ7o4pcBYn9dI7slVzTO5e817UDoHT3Z
         lVEMHSgA/rx5wJwYVE/jKCChowkT13pZD0CDnaW5xg9Zm5tmMZPCy2pRHsECjzKY+/Nz
         5Sjy1J1sllQ1l9n5wJRRie/78NyaUuQJr5eFWG6XIhCARbFQOHj6y+Pviuc164RT4x+n
         6VYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eG6HESFLPWn8glvX0A6+C501emaqPJYVDqCfVaG7yDw=;
        b=L0eeb+kfEln9ofFTW1uEyvQdX3WP4fev858aYfS8gYt6Rv0eqRwT1ATC7JKFbtpYi9
         RoSDnF9OGrt3V7CNgug/impFZRD7PBrgp+7ZBI4gtegXMYxfbifaLPGnGpvP80JzmoqI
         eIgSZj0jlIiN6eEGJDwQwKW0TUaWRbs8bzD2j6gIqW9UEmm45+IcYtEq0uPNOvoS/fLV
         r/2wYDHxNGNxYT3uxxwZHEPgBFZoE1orhiFzvorhmlft+61hLD96IFulx+5TMW/ay/Es
         DhI+7ibd5hEW5XgicfGZ+c2qs97QGtmlTOGwX26iolTNtKFP3TJC6U3rZtwDXOoKCT+m
         m/DA==
X-Gm-Message-State: AOAM5336JQFRH37R9vxQZPuyoqCiOyJyFIOhI5ykR/X5Bz8qs0iJqVjO
        GrYjJVQsJqdcXmU/t+k1eM/XqqJJIQ==
X-Google-Smtp-Source: ABdhPJxb0Im6OIL2JMyffnXmvolIGJxw2N8suiR/vS7MGfxXCuNX5rYG370IWs9wphx+fOx0HLanNA==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr4114158qkk.376.1601675015958;
        Fri, 02 Oct 2020 14:43:35 -0700 (PDT)
Received: from [192.168.1.25] (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id l5sm2101400qtc.28.2020.10.02.14.43.35
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 14:43:35 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: overriding-dsdt doc: kernel parameter description to override the
 SSDT.
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Message-ID: <79dc749a-d55e-a5ae-668e-0e9993261a29@gmail.com>
Date:   Fri, 2 Oct 2020 17:43:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello,

https://01.org/linux-acpi/documentation/overriding-dsdt shows how to
override SSDT and it says that we need to set 'acpi_no_auto_ssdt' kernel
parameter. However, the kernel parameter name was changed by a94e88cdd805
("ACPICA: Tables: Avoid SSDT installation with acpi_gbl_disable_ssdt_table_load.")

Could you fix the description? Like as follows:

===
If you need to modify the code present in an SSDT, then combine all of the SSDTs into a DSDT override, modify it as necessary, and boot with a kernel parameter (*) to prevent Linux from automatically loading the SSDTs listed in the RSDT/XSDT.

(*) Linux-3.15 and before: acpi_no_auto_ssdt
    Linux-3.16 and after:  acpi_no_static_ssdt
===

Thanks,
Masa
