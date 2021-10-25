Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75564397ED
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhJYN7B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 09:59:01 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:60896
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232779AbhJYN7A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 09:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNWx18GKW224vD5aFBOZPJAOqbM09nIUuthD+9dtlVFLoit3ZA0RW2pbMZeLJyYN503Nb0ptqn/5hQ+kbAZKKZtdSJtaXE4EQWsnbjuO3YhmL1+8a7J2km4ZOzmWCuURm/S+wKFSxy5wMdnEUnMt8XBNRigJNqKF+oQpErNFZSnTnGZWdDTRomzy3+bxF1SarjuvseLJ07vK500AKGLZvLghjFy3OjfniwDfnP3dYPmvrILFJtbhjbI2auyBLNN2NzUQG04izB3OoFF5Ov1F5yoy6r6XEkMj5cvDwN2a6TdIXD0rBK3/mbcL7ZDNUJKfhm9SL4jz6CBCYLIN6j0TSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BrsByIzPfDPfL1E63GGquCvxdmp8O48RkwRf97Ut0s=;
 b=HZNGX6KRGNn9H0FwdjBhAwSL9WIQvmfU5kqUXW6gTx9wFVvHUm9Db7mzywip8Q6Ek/07vGI5OuTvCMTA3LFhLhqZd51Vh55Wc9kCtGwGsj2zkqlMgGdQPp/x4bvflKbNKUwwkuTAe8EL1l6zNt+0zhwP7AnkKvnc6NMj7/huupgevCDzL722S9+/2xvxyneZ+nJIcyHQyKR/WsRbg5Z1PTBhMMlejQ0Lb1Zw9OaL9Mws/dGYpukO2hrNOqvEHbFSF0EhQtPLB3kZH7U/5NWrtOtFzZPXsnAR3QIAiyQVmNh5zorIQikkWVlHgp7KBhYYeK4C3JvTXm+gL6EBUEcRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BrsByIzPfDPfL1E63GGquCvxdmp8O48RkwRf97Ut0s=;
 b=C5vkCuyhtyO35nWEF36ah23wol292kBTsbpqJ4NiVLqje8BIWW2vRkYl51GUhzRV25owq1eChSGICy4dDif0ttScQypIrEVoBt9dFXx7fORA2Pce1uhceB+isNVckVjfiMVRnbYJ+hp2PUW2kPIPyvssZwYFStfx2Zo2326xq3M=
Authentication-Results: protonmail.com; dkim=none (message not signed)
 header.d=none;protonmail.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Mon, 25 Oct
 2021 13:56:34 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4628.018; Mon, 25 Oct 2021
 13:56:33 +0000
Message-ID: <7d0c7f12-a412-582e-22f2-8285cf74066a@amd.com>
Date:   Mon, 25 Oct 2021 08:56:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ACPI: platform_profile: Add support for notification
 chains
Content-Language: en-US
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, markpearson@lenovo.com
References: <20211022181608.3121-1-mario.limonciello@amd.com>
 <wH_kPWXl4frtlsEIPSKi7RJwuVoW30nN7WOJhjdV2J91_My1No4OFsCQvoyoJ9hz95IhQ4g7hsTWVL-nn4lNA81ccb8WTqn-2BPPjiEvHzU=@protonmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <wH_kPWXl4frtlsEIPSKi7RJwuVoW30nN7WOJhjdV2J91_My1No4OFsCQvoyoJ9hz95IhQ4g7hsTWVL-nn4lNA81ccb8WTqn-2BPPjiEvHzU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0007.namprd15.prod.outlook.com
 (2603:10b6:207:17::20) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.236.24.110] (165.204.77.1) by BL0PR1501CA0007.namprd15.prod.outlook.com (2603:10b6:207:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 13:56:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f022b78f-aa80-439f-0403-08d997bf4124
X-MS-TrafficTypeDiagnostic: SN6PR12MB2685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26859EE958BD6758CE1F0FDDE2839@SN6PR12MB2685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYpf+/stVX9nYMvghP2nFw+Mpv6/SINz/HT1iCAlGHzC2wLdN7gw+Y9dorZygyyAeIBffhWzGORiXUuGsEPhFgSjamVOoldDQxwOYz1unXWvexczoR6yv56pXNz53AW98xjXGM/IuEl2jXugsOUIAe44eiL9dQDtIZLBtxrGUPklmanltMaInlIzGLjZ3c87ivXALXEJaZJrdQwTlCnDQFV4LPj0W3aUJU/f6ah96Vchdx0kgm9V5+8h5R+I7ah0dwgSR7j1SBeR+nU1qnvUMOyplWXxsszu5mmr7qw3lFPPgm/1rE2fDkhmR8sDxP+C4C3sKm5gcrAUksiRDwyVrtrn1XYiHUGn8dQ+Kzml+1rw2XGGgKmsyLr/Mts876ViYXEU5cys2wfzTrC4gzlcKm5MJdaW8vO4FXz2FDIy+GMZR4Uj79NFk1IcHK1PLWdLpD1jCeGou5VLDjsjO11fN46RUkX4nRDDdEs29qIUJ5nZveA0p0NbQpfyKI9UhhsLrrG9iwEqx5CtFjBiTt0N+prUTQSWNFb85H5FHpMWHYg+YBpa/qB0o/3qPzs8LbGfB9iLlJ8FTzyBfQ0s8qwKEQxvGjY5hX96dK+yfH0SyY4WjOw/KbzFhE6tghEZkc4S2DkHU6IiOgYzQpkd7zecjK2qT+Zf8e8XDCwDTsjaKEj7lVm+4osyL2kHggjywz0WXQeMWWBj52sVt+1/lA5xvZlAjdDkVTmo6P+TFwwKZN1uTuzU++0d56sGZJk8O3Df
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(6486002)(8676002)(5660300002)(2616005)(31686004)(83380400001)(4326008)(16576012)(508600001)(956004)(66556008)(53546011)(15650500001)(66946007)(66476007)(26005)(186003)(36756003)(38100700002)(31696002)(316002)(66574015)(86362001)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWEzTEY1ZlQ2ZDZCbWk0TlJ2SjhLWGQ5K09qYytPK3JmcUpsVWxvcXY5NmRR?=
 =?utf-8?B?bTdEVVFqLzV4cFk4S3phK0NtaU9UbFMxVFJOZVBtTlU3UDF1UHpyRFpMZytu?=
 =?utf-8?B?eGlyVVpDalBLUlF0VjQvOEl6d1N5VGRmZkptZEh2K3dXcUJkNThnanRQcHIz?=
 =?utf-8?B?cUdBVzNHSTk1OVcxU2E0ZCtmc0VnZ3FOWnpzTEo5cjZnODJVVlZVSzQ3NDB5?=
 =?utf-8?B?b0p0MWN0ekVjemdTY2hJTjlaNmsrODJhNTZUTjFsbHdoUTdKL0t3cXpxbkNP?=
 =?utf-8?B?NVYybllpWGhpUnJ2UWtjL0ptQ2hkWU9GY3RSUjBLcTVqYVZZczRRdk10Rm9I?=
 =?utf-8?B?VWVEamZyblp5Q2REUGlIZmFiSEl1TDdYM2l3YWhZUGVaZUYwbG9WQnlBUEtV?=
 =?utf-8?B?K00rcGpPaThEYXRDVmVSNVRMTE5BZkI5WGZjbmJSa2hidlFTNlN1TUplb3FT?=
 =?utf-8?B?U2tQVHN6R3IwWWs5WFhZYUtxc1Bmb3EvZ2FOdVZzWlhkcFlkUWgxbGR6YkJh?=
 =?utf-8?B?WjRacGd4K1czd25uVUhXOUYxRGgycGJkNE5UdkFXMzczZ0VmbmlScWFYVjhL?=
 =?utf-8?B?NEJUQUwwZmpOZXdyQzJFbEhLaWVFUDZyRVFER2RHdGE5NWg5ZlRsOFhRL3p0?=
 =?utf-8?B?VVdIeG9tdjJwT0hoWTc0R3ZTQ2NDbXN1azNnc0huVURrV25CSThwN3Rnc3pG?=
 =?utf-8?B?NEcvRGQvQ3ZmMGptMTQ0cXo2V1VhZDMyNDNXeG8yUll4a1BBUnlZVy9IVUMx?=
 =?utf-8?B?bGVpSExmV014a0hNUVpzd2xHTERIZjgwaGlQeXZsZnpKSW44TVRQa3Nzd21i?=
 =?utf-8?B?Q1BTNnhYTWQxTEJYWDNuRHhsUDhHVDhiNUVWVmZFQi8zOFAyYjZBQjF6N08y?=
 =?utf-8?B?UGQwbmNnMmZhNXdnOHdqRHVaMndYY2UxT2p4c1ZCMGN0UEJ2cC9nRW1Gd28v?=
 =?utf-8?B?TE15ZEpCZXNid3B5NUpyNGNDU3VFTWxUMEhVaDJpc0M1K2NtNmtTSUFXTTZv?=
 =?utf-8?B?amFrUzQ5VWdGTjd6VFZWWnQxRTUwdmQ2RG5iTnJsZGljcW45LzhGUGVxSUgr?=
 =?utf-8?B?Wk82a1JYRjJSc1pwS0hsNUZsb0ZxR1BBbnlqaWRwbWdCMkpnSlB6WUgwYThn?=
 =?utf-8?B?cjR2cmQrYXJ1SVI1TVhEa3ZCejJSRHhEblNiVXNsbVZlRUpPcnEvWk93NnRl?=
 =?utf-8?B?Yzcwa0ZvUmN2dmIvVEJwK2E1WHQwSzJPdG9veHJqMkcrNVpIZk9Kei85ZnE5?=
 =?utf-8?B?T1g5cWlOZjVwYmMycGs2NmFSSHprNkJFaWdJUzJldmJNWWN5MjRHUkdDeVRn?=
 =?utf-8?B?WE9KUy9HRVlzbGVZL0pZZjdtL3NzbzYvSG11ZTJvWmY3SllZb0laeWJTbGFx?=
 =?utf-8?B?eDhRSGc3YUQwWHRQOElLSTlNU1BiaGNsNXRpK3k1Z0Y3YkxFajQ4bzhCcy8v?=
 =?utf-8?B?NVEvT05QMlVhYVNQa01FNFl1MkFERURsWlVUaFBIUERTcDVUMWhvM1laWjcv?=
 =?utf-8?B?RmhZTnVDWVFNaEQ1cVBCa1hCYUsxU1pDV1FNQkJwMkh3WGFnYjI3ckFsTHFy?=
 =?utf-8?B?VWxwVGhpREhYNnhyTUZNd1h5UWNpOWpFenNDcDBrVE9jek5XQm0zZkIzRXpl?=
 =?utf-8?B?TXFwZVFNWlExeUZRQ29hNEQyM2l3YisxZ1ZKbFdyQnVKaTNIZVRXc2lGYXdH?=
 =?utf-8?B?bkVucUNsN25XVXg2UHlUU3F5bUZqdGl1VE5wa1I4bXUydHBjMnBPT1JCU1lW?=
 =?utf-8?B?OUU5THQ4NUNsOWN4SVQ2TFY5ZTFlazI2NUdRd1oxWGpXOHh3bURzRmkybXZQ?=
 =?utf-8?B?WC9qNzViSUNCWU1Bc3hBWGUzS2JLeW1yT1llQ1RZdnRVcHhmQjdObnRES2xw?=
 =?utf-8?B?Zll0STVrVGJJekNvTUlQTTBOMzJoNGVjTmptMjg2UVdiUUpjaVlrSkc1OGt4?=
 =?utf-8?B?L3Q5SUs4NVBVcVVsbkxLNXNsL3FCdG56R2pCRDk0RUtWZjFzaE9JdTVRYmpL?=
 =?utf-8?B?ZUdXU3VLZkdML3NIM0NzeFczZ1RqSVdmSUtNc1cyRW9NeGZsZkZWaCtqVEZr?=
 =?utf-8?B?VW13N0ExM1RPZDEydWpqS3l6czlNRzcxelFJMTkvVVRqMVJ1cGxiVnkvZEJj?=
 =?utf-8?B?bFFlT3c5b0E3bjRUanpSVW80TS9hV3Bha1lkWFVVVjBBWWVzMW9Sdys1emF0?=
 =?utf-8?Q?fcxd2RY7SPP/ZsA5i3CEUIQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f022b78f-aa80-439f-0403-08d997bf4124
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 13:56:33.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ2y8EsfNO6L5UFw/Nh+eVa+/d6T7YFOz8iZAqw6GNRdQrB25ZbYjFECAoXIHoJqQrjHaHnKCe4xtrB1g0j3+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 10/24/2021 08:40, Barnabás Pőcze wrote:
> Hi
> 
> 
> Am I right in thinking that this adds functionality that has no users in the
> kernel at the moment?
> 
> 

That's correct.  I have a few ideas for consumers of it, but I wanted to 
make sure that this approach is acceptable before spending too much 
effort building on top of it.

> 2021. október 22., péntek 20:16 keltezéssel, Mario Limonciello írta:
> 
>> Allow other drivers to react to determine current active profile
>> and react to platform profile changes.
>>
>> Drivers wishing to utilize this should register for notification
>> at module load and unregister when unloading.
>>
>> Notifications will come in the form of a notifier call.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c  | 44 +++++++++++++++++++++++++++-----
>>   include/linux/platform_profile.h | 11 ++++++++
>>   2 files changed, 49 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index dd2fbf38e414..964e0c9bf70d 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -21,6 +21,25 @@ static const char * const profile_names[] = {
>>   	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
>>   };
>>   static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
>> +static BLOCKING_NOTIFIER_HEAD(platform_profile_chain_head);
>> +
>> +int platform_profile_register_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_register(&platform_profile_chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_register_notifier);
>> +
>> +int platform_profile_unregister_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_unregister(&platform_profile_chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_unregister_notifier);
>> +
>> +void platform_profile_call_notifier(unsigned long action, void *data)
>> +{
>> +	blocking_notifier_call_chain(&platform_profile_chain_head, action, data);
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_call_notifier);
> 
> What is the reason for exporting this function?
> 

Thanks for catching this.  You're right - this doesn't need to be 
exported, it's only needed to be used by platform_profile_notify and can 
be static to platform_profile.c

Will fix up on the next version.

> 
>>
>>   static ssize_t platform_profile_choices_show(struct device *dev,
>>   					struct device_attribute *attr,
>> @@ -49,11 +68,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>>   	return len;
>>   }
>>
>> -static ssize_t platform_profile_show(struct device *dev,
>> -					struct device_attribute *attr,
>> -					char *buf)
>> +int platform_profile_get(enum platform_profile_option *profile)
>>   {
>> -	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>>   	int err;
>>
>>   	err = mutex_lock_interruptible(&profile_lock);
>> @@ -65,15 +81,28 @@ static ssize_t platform_profile_show(struct device *dev,
>>   		return -ENODEV;
>>   	}
>>
>> -	err = cur_profile->profile_get(cur_profile, &profile);
>> +	err = cur_profile->profile_get(cur_profile, profile);
>>   	mutex_unlock(&profile_lock);
>>   	if (err)
>>   		return err;
>>
>>   	/* Check that profile is valid index */
>> -	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>> +	if (WARN_ON((*profile < 0) || (*profile >= ARRAY_SIZE(profile_names))))
>>   		return -EIO;
>>
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(platform_profile_get);
>> +
>> +static ssize_t platform_profile_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
>> +	int ret = platform_profile_get(&profile);
>> +
>> +	if (ret)
>> +		return ret;
>>   	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>>   }
>>
>> @@ -130,9 +159,12 @@ void platform_profile_notify(void)
>>   	if (!cur_profile)
>>   		return;
>>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +	platform_profile_call_notifier(PLATFORM_PROFILE_CHANGED, NULL);
>> +
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>>
>> +
>>   int platform_profile_register(struct platform_profile_handler *pprof)
>>   {
>>   	int err;
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> index e5cbb6841f3a..390d95d47e07 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -11,6 +11,8 @@
>>
>>   #include <linux/bitops.h>
>>
>> +struct notifier_block;
>> +
>>   /*
>>    * If more options are added please update profile_names array in
>>    * platform_profile.c and sysfs-platform_profile documentation.
>> @@ -37,5 +39,14 @@ struct platform_profile_handler {
>>   int platform_profile_register(struct platform_profile_handler *pprof);
>>   int platform_profile_remove(void);
>>   void platform_profile_notify(void);
>> +int platform_profile_get(enum platform_profile_option *profile);
>> +
>> +int platform_profile_register_notifier(struct notifier_block *nb);
>> +int platform_profile_unregister_notifier(struct notifier_block *nb);
>> +void platform_profile_call_notifier(unsigned long action, void *data);
>> +
>> +enum platform_profile_notifier_actions {
>> +	PLATFORM_PROFILE_CHANGED,
>> +};
>>
>>   #endif  /*_PLATFORM_PROFILE_H_*/
>> --
>> 2.25.1
> 
> 
> Regards,
> Barnabás Pőcze
> 

