Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6941AF92
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Sep 2021 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhI1NCi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Sep 2021 09:02:38 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:41062
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240300AbhI1NCi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Sep 2021 09:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxxx4Mjl9gshw3HoUUEPQqC0AxvronKNeaHumc7EcTxWRnIK5XzCW2O24nmZoXVgjrfPVG3OkHbLPrpDgvTiS/ImL0pHQRd2QAdcx8R7lANUYkgOwZ91NTqR7IkBru3sm5KZvst//o1yDxmmcQhA7lCq9vnRDdP7hr4V7uww0VLqPVkZS308Hw5NbmUzOxBurBQAhHhH1v+a2OyS0HnO6Vni0XYkbea5CUt36RVljoYN3zql+4XcruS0+O/E9N23dV/Be7PagMQpexf0ZY9bQJWipNM3JQT4LG3KwoDOKqXd6JwBylY0deSGbUAl+voLVNKBrCRJTI78J1SE35toiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=foZSW8arBkV3kWi+0Qxf8bLEE41/l2Uq4fm11djW3Rk=;
 b=oUN8hUJRi8X6EkahPdwM3o1ag3WscdRM+I9orAxI4tnGgbtit/6fG2NiBB9KIOOH5yGOxMhaLkIJFRq1RehJLA2o31NnlaM5Br/b2UFfVTx5s6XuqkvIQGDrPkY+cvfvNTUBHOP97uZqGFcZ5iZ/rFY0Ym5ZJOP9hC32a86Lu80N/BtLcLDtdZuXe8tPzlS3Y1RGkX3Iv8q36znAR5IIeKivpGX1bvWid6uSORwfmohDS9wGbZq7+twywr7yTjkFzBOyCYE2j0BMOPzn9io41/OszMPir+W5nFGSzgf/GWfjj4h5vpEspsN+nSKxQU9YBUGHx7xxdeECOg9VyUvSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foZSW8arBkV3kWi+0Qxf8bLEE41/l2Uq4fm11djW3Rk=;
 b=Oea/9NP3vpVIiqX0wbKSR0hnTy07K6u7bggpjAwVM0sqV0xS8yDi6G+htnO9U3LQrQvyoMcLDVwD+et/uZQMSuwwAWwNsBC40zhNXR4OWDMVaq2zLuBygP++k+T+C5u81cV/6tPnOZuSQLoQuPdZRyDHQvBCVEMDdpbVmG5Ss4c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3062.namprd12.prod.outlook.com (2603:10b6:a03:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 13:00:55 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::2c4e:8ff7:5c3c:25d9]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::2c4e:8ff7:5c3c:25d9%5]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 13:00:55 +0000
Message-ID: <3b26b179-69ba-64a2-807e-8d7609fbeb6e@amd.com>
Date:   Tue, 28 Sep 2021 08:00:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lijo.lazar@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20210922133116.102-1-richard.gong@amd.com>
 <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
From:   "Gong, Richard" <richard.gong@amd.com>
In-Reply-To: <CAJZ5v0jpOzNS5TFdJNXdxa_p2D_5QQMwwRcSMe8JmjOaTjR8gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:806:d1::14) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
Received: from [10.254.56.127] (165.204.77.11) by SA0PR11CA0099.namprd11.prod.outlook.com (2603:10b6:806:d1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Tue, 28 Sep 2021 13:00:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 712fbc79-b7b9-4f05-e4cc-08d982800211
X-MS-TrafficTypeDiagnostic: BYAPR12MB3062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3062F2EA94F0AA6FE415C33F95A89@BYAPR12MB3062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzeAiZ5Xih6htwPWMCUgaUUpegzh2vuRAkT3WnClwUBEcVpXoicLcsvhnQhkYW77FkzTHhe72tkOHOs/3CzbMdfo+BFP7Jik9ouC2x/Mw4rQyFtlxUWCGdEHCG7NjCR1P7Los/v+dE0m+gv2EZZ3LZZT4sECWKoBmBrow1rCNZPmBEQdrOLLi7XPsUFXsXRP+tBnM97hfP/xbagXa+bWqU6fUJhDZbpOWKclfYaTLRRP78rwqJK4AnxUU554Dv0G+oJ90l0ZYoPDJgUaqhCYkEZZNMJLhQC8+WEbjwU3W/uLZAEj32psNiv5oMAyijFupiSduSp7QdtQ0Pwj30iuze/gm3LZD0yXsmvGUElKE602FWQUDLS6wJ1cnt6TH9EoYMfW/n7erwqOycdI6Wu6bUdzgTR/A2t9Bdktb+kkbYT9eV7l/xYXTFWhLAqex7ZCsp1o+ePj95YrbkjtR0AgmRDvIJoEVPEAqyyzGrGfh9FR1aA0RZZ7Jn56TsCY0/wKkuUG5VxG+1chCfRQZV+TnH5yccqmbee0BqxFDjKAQQdCOZ2+3yQLDDPpW0DOADPb48YyoJBL6yAV8+ZrUh5SfY47xhGc+oTEuhkfKWvINhboRJOaRedeQ/AhU2XE45SQKy4Gcj7Lzv0NOVdh//2wKvIjhitJJmyGZrljC7PSRdDy3AdiTJ9pOUOH1BwxM6S4Kd2yWGEh79YLA2xpjzkf67ykxm33BQS7w0qD5uwclrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(45080400002)(86362001)(8936002)(2906002)(54906003)(83380400001)(508600001)(186003)(31696002)(53546011)(31686004)(16576012)(966005)(316002)(26005)(66946007)(8676002)(66556008)(5660300002)(6486002)(4326008)(2616005)(956004)(6916009)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cStYaUpzM1RPNjIxK3Rtc0Z2YmowQUhFcWJINk1oUlM0TitWVHJOa2VvYlhV?=
 =?utf-8?B?S0NDWEd2R3FZbko4aWpDUWRRMzBQaHJhUUNXNjJKZ1FDRGFTR2toZnhHcFFD?=
 =?utf-8?B?Yjk3VnlPNFdIa3V6U041dUk4Q3RveUZPL1BKZTQzRUpIYUUrYlRObjdwUFZi?=
 =?utf-8?B?SnJtUGlZSUk0WkRuNS9IV3lGY1JiZkVQSFhReVdlOHQ2MVUySkNEQ3pNSHdU?=
 =?utf-8?B?VWhOT0p6V3IxeVJsY0JPRjlQUWwyOHdLcVduaklyL1JPeGtKSU9nUTdaUDhT?=
 =?utf-8?B?OFM0b2llYjhTKytld1JCR0F2NWZlVGV6SjlwUVU4T1RLRFloaDBiTGR6b3d4?=
 =?utf-8?B?RGM2QW5xNXlpWThLSjBYRlMwRGJuTnJ6ZWM2Q25kUXFQa1hWTXdDQVdGWUJ4?=
 =?utf-8?B?YmtqaUl0ZURSU2N6NFhXUzJXd1hPTGRRWHNwd0l5TUJZNG51L2M5akFTU0xq?=
 =?utf-8?B?ZDFYeFpaYVkwWklBYjAxQk5RTXlTY0dVTUc3cTFuVnZsTUR5SWZiS3h5cDdn?=
 =?utf-8?B?RE5ndVNTVTExZGlkdVY0azdDUXJhL0NKbXF3YVM2bU8reVgyQVBKVVNrSCtR?=
 =?utf-8?B?SENCQnczZFYrN04yZ21ua0ZVOVVTblZzS0VhNm51VnBES253dldoR1E5dktC?=
 =?utf-8?B?cnNoejltWGpvUnFtdGtpNEtsdG42bzIvSENtVG1JQWZJSmg0SzJxVDBTb2JR?=
 =?utf-8?B?V04rS1B2T0ljM3V4QVVKRXBDb3dORjVvbnI0ckJKMm9yUmlZaTN2clVSS3dm?=
 =?utf-8?B?Sm5OR3c2aG4vNlRrbmpMY2pTYTVkdS9tUXZKNmpPbDRJRkoxWXlGV3ZPL0Ry?=
 =?utf-8?B?dE51bXdvZXgrbldtTWVQNzJ3ekFETmhJcW9zSDUwejF4aER2R1JXQVYrM2JL?=
 =?utf-8?B?VFBwU3IvUzZ2WG1zMC8yMC9NVWxONmo1ZEFlbXlWQmNaRkhENjRFWFFuQ2RW?=
 =?utf-8?B?WndKcmdUSTNBMXFTSW80bGlBTENWUUtnNDVoTklFTVA3OUEyQm5MUkNLS2lH?=
 =?utf-8?B?UHF2ZEpJS09EYWc3N3ppSEhINlorWFBPMDk1NEdodjhsNEFkZURUMURyK2pR?=
 =?utf-8?B?aVdWS3BLZVc5dmV1OFpyZzdqaVZLQnNIbkZJdjVYWTJkL2lXWTVSRjBJRW01?=
 =?utf-8?B?UWlDbHBkcHNKdGtuQWFpUFdxcHdSQ1FHOEdoSkpvcnRDaVNieDdtd1llZnN4?=
 =?utf-8?B?WWVSTTlXL0xUcHk1aElMQnZGMEFqeWZqSXp5b3liZ1VGSzh3Nm02d24vM1Fy?=
 =?utf-8?B?V0VUbWxOdkRqeGpzdHdWY1cwMGw5SURoZ3o2KzVYTjJ1R0U3UHVHblg0ME43?=
 =?utf-8?B?RTZkNXhCVDc1a0dnSGg5Y3lKbVhhdFNIMWZ2VENxVSt6a0d2MXMyUGY0SGky?=
 =?utf-8?B?SVVOZWV1RkNJY3ZwcnJibTZBTFVqMzRlWGdhUGszcjhOQkkxWTJiNnN3ZEVR?=
 =?utf-8?B?aStsdVMzWnM5VnFmZzB5ZzZDMmlVT0FmSWppR0pjRHB1eklYQVE3WWplUXBG?=
 =?utf-8?B?NjBHUDh5MUxEcVYyMjRQd1hGRm9NSlNmNlZFZCtRZk1aOVRldndkSFlMVzJG?=
 =?utf-8?B?aGlzV0JBWWZFQ1RkcTgxaElYMUp5RUdFQXhYNWdDQ3J3MC8rY096OG5zVVlx?=
 =?utf-8?B?YnRkZ0QzcmsvcWU3THZpdEM2MFZYbDh5blg1cVRwQW1ZY1dDS3dpN1FrRmI5?=
 =?utf-8?B?VVo5T3NBOFdBd3NrY2V6NXdta0F4OGpJd1AzT1pybGZ4OHZhQjN4bzlFUXU3?=
 =?utf-8?Q?MHwRP9Pgq1cVi9A1GCPQbp8oVTzfNoPECCTAQLG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712fbc79-b7b9-4f05-e4cc-08d982800211
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 13:00:55.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q490dMldV4NNaT5ilPyE0t+FYHN/LqmntU6RmJv6izVvQaozcehTtsjzJeNiFhmhAM01OTUPX8QUhX83auqjuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3062
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 9/24/2021 11:31 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 22, 2021 at 3:31 PM Richard Gong <richard.gong@amd.com> wrote:
>> When some cores are disabled on AMD platforms, the system will no longer
>> be able to enter suspend-to-idle s0ix.
>>
>> Update to allow playing dead in C3 state so that the CPUs can enter the
>> deepest state on AMD platforms.
>>
>> BugLink: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1708&amp;data=04%7C01%7Crichard.gong%40amd.com%7Ca5c0db9ce02b4cd0864f08d97f78d33f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637680980065602427%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=dIO5PDjpncLFIt0aGaTrKJHYIkJm8A4YByGn1%2FsHrtM%3D&amp;reserved=0
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Richard Gong <richard.gong@amd.com>
>> ---
>>   drivers/acpi/processor_idle.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
>> index f37fba9e5ba0..61d5a72d218e 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
>>                  state->enter = acpi_idle_enter;
>>
>>                  state->flags = 0;
>> -               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
>> +               if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2
>> +                       || cx->type == ACPI_STATE_C3) {
>>                          state->enter_dead = acpi_idle_play_dead;
>>                          drv->safe_state_index = count;
>>                  }
>> --
> Tentatively applied as 5.16 material, but have you done any research
> on why this restriction has been there in the first place?

Yes, we need this change to align with the updated firmware on AMD 
platforms.

Regards,

Richard

