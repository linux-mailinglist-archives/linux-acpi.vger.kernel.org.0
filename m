Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBED2BD33
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2019 04:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfE1C0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 22:26:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36767 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfE1C0y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 22:26:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so9992208pgb.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 19:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PbAlnbMG3ZQsuTiPzcj5dR2K8h+JQcEEAbcsQKzHrp8=;
        b=VTiNwQT9ngEv4fGQldDwmwNpeLWpsu6SR50x7OfHNIq+PZbu2FxUchJjUWpV1KG9W7
         +O09yXGsURhBHPPerTLS84kxR/Ze8kuYI75fVsmtS0eaDe9+r+frVodGkjQ/XNg27AZm
         Q5Ojd70jtTWIhCAD1gkxDMePKzeKRwyRrUmuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PbAlnbMG3ZQsuTiPzcj5dR2K8h+JQcEEAbcsQKzHrp8=;
        b=hJFrNG26YHuLbwpv50slWukDYqoWRzyf7qjCqA5lVxCTLXw0W8uGLhCKLUk8PYfD2F
         yJOXORo9HHa9Q5vr9kutCnJ4Yl+e2LXA/tV+2v7sEMAzePGaMPEnh8StQzN7odzcF5Zn
         mqunhzaF87AE6S+a7KEBaSzT1u0eQ1Qs9hqn3lQ3kaOYhWKVe7OZuXLSua3GMCnpDOxV
         mLzTs9EVb2cp8c1MUc0G3iCEsebA+vrnVZ4FZwI88GAczovx9uyIVzGTmmLzYZcXNAHN
         C1kPNdMJDY8dXlTRBbvVcp4JwaCBEraS1/v4cHNDSoAiUJ+pKotJsOzzgL28+E9FeNV2
         UFQg==
X-Gm-Message-State: APjAAAWdIgg7iDOonGjZ78ZPtutKFf0NqVaz7mlljW13NbJpv542YwwI
        1zwA4dxkcsOJGbXGSMv+BWVHMg==
X-Google-Smtp-Source: APXvYqx+VY3FarvHW7iBaypvG6dz7YPmC7OnZveSMATrcMjnfNcPSxPUaSYfs1JcSyOp5shSR2CCYA==
X-Received: by 2002:a17:90a:bb8d:: with SMTP id v13mr2260630pjr.79.1559010414042;
        Mon, 27 May 2019 19:26:54 -0700 (PDT)
Received: from localhost ([128.107.241.177])
        by smtp.gmail.com with ESMTPSA id l38sm720404pje.12.2019.05.27.19.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 19:26:53 -0700 (PDT)
References: <20190505193435.3248-1-ruslan@babayev.com> <20190525005302.27164-1-ruslan@babayev.com> <20190527083943.GX2781@lahna.fi.intel.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ruslan Babayev <ruslan@babayev.com>,
        Wolfram Sang <wsa@the-dreams.de>, xe-linux-external@cisco.com,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
In-reply-to: <20190527083943.GX2781@lahna.fi.intel.com>
Date:   Mon, 27 May 2019 19:26:53 -0700
Message-ID: <8736kz9uvm.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Mika Westerberg writes:

> On Fri, May 24, 2019 at 05:53:01PM -0700, Ruslan Babayev wrote:
>> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
>>  #else
>>  static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
>>  					     struct acpi_resource_i2c_serialbus **i2c)
>> @@ -996,6 +998,10 @@ static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
>>  {
>>  	return NULL;
>>  }
>> +struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
>
> This should be static inline, I think.
>
>> +{
>> +	return NULL;
>> +}
>>  #endif /* CONFIG_ACPI */
>>  
>>  #endif /* _LINUX_I2C_H */
>> -- 
>> 2.17.1

Thanks Mika, will make the change and repost the patches.
