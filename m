Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A5487196
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jan 2022 05:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiAGECP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jan 2022 23:02:15 -0500
Received: from marcansoft.com ([212.63.210.85]:55538 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbiAGECP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jan 2022 23:02:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BFEE34212E;
        Fri,  7 Jan 2022 04:02:03 +0000 (UTC)
Message-ID: <25eaec8a-337e-78b7-1bc3-7224a0218501@marcan.st>
Date:   Fri, 7 Jan 2022 13:02:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 06/35] brcmfmac: firmware: Support passing in multiple
 board_types
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220104072658.69756-1-marcan@marcan.st>
 <20220104072658.69756-7-marcan@marcan.st>
 <911f7e95-7d6a-1c7f-c8de-0d4e0c7b7238@broadcom.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <911f7e95-7d6a-1c7f-c8de-0d4e0c7b7238@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/01/06 21:16, Arend van Spriel wrote:
> On 1/4/2022 8:26 AM, Hector Martin wrote:
>> In order to make use of the multiple alt_path functionality, change
>> board_type to an array. Bus drivers can pass in a NULL-terminated list
>> of board type strings to try for the firmware fetch.
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/firmware.c    | 35 ++++++++++++-------
>>   .../broadcom/brcm80211/brcmfmac/firmware.h    |  2 +-
>>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  4 ++-
>>   .../broadcom/brcm80211/brcmfmac/sdio.c        |  2 +-
>>   4 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> index 7570dbf22cdd..054ea3ed133e 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> @@ -594,28 +594,39 @@ static int brcmf_fw_complete_request(const struct firmware *fw,
>>   	return (cur->flags & BRCMF_FW_REQF_OPTIONAL) ? 0 : ret;
>>   }
>>   
>> -static int brcm_alt_fw_paths(const char *path, const char *board_type,
>> +static int brcm_alt_fw_paths(const char *path, struct brcmf_fw *fwctx,
>>   			     const char *alt_paths[BRCMF_FW_MAX_ALT_PATHS])
>>   {
>> +	const char **board_types = fwctx->req->board_types;
>> +	unsigned int i;
>>   	char alt_path[BRCMF_FW_NAME_LEN];
>>   	const char *suffix;
> 
> [...]
> 
>> +	for (i = 0; i < BRCMF_FW_MAX_ALT_PATHS; i++) {
>> +		if (!board_types[i])
>> +		    break;
>>   
>> -	strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>> -	strlcat(alt_path, board_type, BRCMF_FW_NAME_LEN);
>> -	strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
>> +		/* strip extension at the end */
>> +		strscpy(alt_path, path, BRCMF_FW_NAME_LEN);
>> +		alt_path[suffix - path] = 0;
>>   
>> -	alt_paths[0] = kstrdup(alt_path, GFP_KERNEL);
>> +		strlcat(alt_path, ".", BRCMF_FW_NAME_LEN);
>> +		strlcat(alt_path, board_types[i], BRCMF_FW_NAME_LEN);
>> +		strlcat(alt_path, suffix, BRCMF_FW_NAME_LEN);
>> +
>> +		alt_paths[i] = kstrdup(alt_path, GFP_KERNEL);
>> +		brcmf_dbg(TRACE, "FW alt path: %s\n", alt_paths[i]);
> 
> Could use alt_path in the debug print thus avoiding additional array 
> access (working hard to find those nits to pick ;-) ).
> 

So you're saying my code is so good you have to resort to nits on this
level to make it clear you read it, right? ;-)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
