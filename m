Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEE85F1C3
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGDDTA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 23:19:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGDDTA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 23:19:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so2220667pff.8
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jul 2019 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kknuiE25JazcoWI+ohjzHmUKAkhig4V+ZiiIxT9Gyb4=;
        b=d27RkAq9gKLJqrY+FycTST6nQXQQSRTiG8AB7gDmrCz6MV8pBTjJrlEeFVwZU9HJqk
         VJXfzcCghYPG+VRhuGsMS/sG3qOEeLXnZ/5JFCSXJmojrRwyqUMQfBKzNPfzuyZw2FcP
         b3GlyHnPYzJ5XtuEuoL3eXjfZ9XZlrp9R7qlsPOOwXaaBEZsjL0QULe1Y24HMZnt5EUe
         MwK4ezYEm3xazpgP/+CB67NcacklSUP8ag5GsyEIs86R7tIllqysNCq7iwknpKYRYucY
         o5xd6cJfhNAVNqY9EbVTEzPYs1lJ3lzxCZ4Gcvv+yudL0VQrNobBljxJcS8kCLkBd3D7
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kknuiE25JazcoWI+ohjzHmUKAkhig4V+ZiiIxT9Gyb4=;
        b=RUWOdD+PoPLTk0r6RfwVKLJi4unTWZBVp1nEGS1r2w22iIdEsCwVRTwCjaZlBGFdK6
         DxP8acXIWlf9PBgXUfoJJ2P2AXhbyKCNP2A9xIRaWXuK+5p76beAGxnlrxO+zPsdfxXx
         j1Qo8pQ06nZdd3dK2xQ/zcuF09CatwSUkLSIaufLxFfWYFsPAgKI07lk5hhLCQu5o8EM
         N9M23yFzKsIt7wMv0EgRHCkYQ0tEQbza8sR8XeSK7TX3xc1NTSGHcRP0tX1XLjjxVl8U
         WmsUG4stIDm9flts08w5D7Gjqcs5z9+DBq8xLjSPVYpyxIuK73MRj/xCt57rn+NJOfmk
         reEg==
X-Gm-Message-State: APjAAAX45Swr0DLuFV6a0ntVw9Ynv5XPvjW/IysiNXwH8UAr6ac2XhDE
        3gRe9q+9YafdTf+xwQ8xWoybiw==
X-Google-Smtp-Source: APXvYqzaPtJIZTxux2+hj4YNN+mXNrtHYW7qJYP/0i9PfTolR0OAk0Ic6hyutbOKjiN8aZcJQNt1/Q==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr31597381pgv.112.1562210339316;
        Wed, 03 Jul 2019 20:18:59 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id r6sm3137424pji.0.2019.07.03.20.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 20:18:58 -0700 (PDT)
Date:   Thu, 4 Jul 2019 08:48:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [pm:linux-next 91/102] include/linux/pm_qos.h:197:9: error:
 expected '(' before 'type'
Message-ID: <20190704031856.bpmvzbcor2idqj66@vireshk-i7>
References: <201907040956.ywZASIcA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907040956.ywZASIcA%lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 04-07-19, 09:04, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> head:   267eacd79cadd5e2d6307320497d66119907c411
> commit: 57fa6137402b98327d1247c5aaf3d4f0595a73fe [91/102] PM / QOS: Pass request type to dev_pm_qos_read_value()
> config: riscv-allnoconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 57fa6137402b98327d1247c5aaf3d4f0595a73fe
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from kernel//power/qos.c:33:0:
>    include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
> >> include/linux/pm_qos.h:197:9: error: expected '(' before 'type'
>      switch type {
>             ^~~~
>    include/linux/pm_qos.h:197:9: warning: statement with no effect [-Wunused-value]
> >> include/linux/pm_qos.h:204:1: warning: no return statement in function returning non-void [-Wreturn-type]
>     }
>     ^
>    include/linux/pm_qos.h: At top level:
>    include/linux/pm_qos.h:219:4: error: expected identifier or '(' before '{' token
>        { return 0; }
>        ^
>    include/linux/pm_qos.h:216:19: warning: 'dev_pm_qos_add_notifier' declared 'static' but never defined [-Wunused-function]
>     static inline int dev_pm_qos_add_notifier(struct device *dev,

Very embarrassing. Fixed these two now. Thanks.

-- 
viresh
